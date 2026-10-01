import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nyro_cryto/model/coinbase_product.dart';
import 'package:nyro_cryto/model/coinbase_ticker.dart';
import 'package:nyro_cryto/model/market_snapshot.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MarketDataService {
  MarketDataService({String? coinGeckoApiKey})
    : dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Accept': 'application/json',
            if (coinGeckoApiKey != null && coinGeckoApiKey.isNotEmpty)
              'x-cg-demo-api-key': coinGeckoApiKey,
          },
        ),
      );

  double? _calculate24HourChange({
    required double currentPrice,
    required double? openingPrice,
    required double? fallback,
  }) {
    if (openingPrice == null || openingPrice == 0) {
      return fallback;
    }

    return ((currentPrice - openingPrice) / openingPrice) * 100;
  }

  Map<String, dynamic>? _decodeWebSocketMessage(dynamic message) {
    try {
      final text = message is String
          ? message
          : message is List<int>
          ? utf8.decode(message)
          : null;

      if (text == null) {
        return null;
      }

      final decoded = jsonDecode(text);

      return decoded is Map ? Map<String, dynamic>.from(decoded) : null;
    } catch (_) {
      return null;
    }
  }

  final Dio dio;
  static const _coinGeckoBaseUrl = 'https://api.coingecko.com/api/v3';
  static const _coinbaseProductsUrl = 'https://api.exchange.coinbase.com';
  static const _coinbaseWebSocketUrl = 'wss://ws-feed.exchange.coinbase.com';
  static const _marketCacheDuration = Duration(minutes: 1);

  List<MarketSnapshot>? _cachedMarkets;
  DateTime? _cachedMarketsAt;

  Future<List<MarketSnapshot>> getAllMarkets() async {
    return _getCachedCoinGeckoMarkets();
  }

  Future<List<MarketSnapshot>> _getCachedCoinGeckoMarkets() async {
    final cachedMarkets = _cachedMarkets;
    final cachedAt = _cachedMarketsAt;

    if (cachedMarkets != null &&
        cachedAt != null &&
        DateTime.now().difference(cachedAt) < _marketCacheDuration) {
      return cachedMarkets;
    }

    const perPage = 250;
    final allMarkets = <MarketSnapshot>[];
    var page = 1;

    while (true) {
      final pageMarkets = await _getCoinGeckoPage(page: page, perPage: perPage);

      allMarkets.addAll(pageMarkets);

      if (pageMarkets.length < perPage) {
        break;
      }

      page++;
    }

    final markets = List<MarketSnapshot>.unmodifiable(allMarkets);
    _cachedMarkets = markets;
    _cachedMarketsAt = DateTime.now();
    return markets;
  }

  Future<List<CoinbaseProduct>> getCoinbaseUsdProducts() async {
    final response = await dio.get<List<dynamic>>(
      '$_coinbaseProductsUrl/products',
    );

    final products = <CoinbaseProduct>[];

    for (final item in response.data ?? const <dynamic>[]) {
      if (item is! Map<String, dynamic>) {
        continue;
      }

      final product = CoinbaseProduct.fromMap(item);

      if (product.isActiveUsdProduct) {
        products.add(product);
      }
    }

    return List<CoinbaseProduct>.unmodifiable(products);
  }

  Map<String, MarketSnapshot> matchCoinbaseProductsToMarkets({
    required List<MarketSnapshot> markets,
    required List<CoinbaseProduct> products,
  }) {
    final marketsBySymbol = <String, MarketSnapshot>{};

    for (final market in markets) {
      final symbol = market.symbol?.trim().toUpperCase();

      if (symbol == null || symbol.isEmpty) {
        continue;
      }

      // Keep the first market when symbols are duplicated.
      marketsBySymbol.putIfAbsent(symbol, () => market);
    }

    final matches = <String, MarketSnapshot>{};

    for (final product in products) {
      final market = marketsBySymbol[product.baseCurrency];

      if (market != null) {
        matches[product.id] = market;
      }
    }

    return Map<String, MarketSnapshot>.unmodifiable(matches);
  }

  Stream<CoinbaseTicker> streamCoinbasePrices({
    required List<String> productIds,
  }) async* {
    if (productIds.isEmpty) {
      return;
    }

    var reconnectDelay = const Duration(seconds: 1);

    while (true) {
      WebSocketChannel? channel;

      try {
        channel = WebSocketChannel.connect(Uri.parse(_coinbaseWebSocketUrl));

        channel.sink.add(
          jsonEncode({
            'type': 'subscribe',
            'product_ids': productIds,
            'channels': ['ticker'],
          }),
        );

        await for (final message in channel.stream) {
          final decoded = _decodeWebSocketMessage(message);

          if (decoded == null) {
            continue;
          }

          if (decoded['type'] == 'error') {
            throw StateError(
              decoded['message']?.toString() ?? 'Coinbase WebSocket error',
            );
          }

          if (decoded['type'] != 'ticker') {
            continue;
          }

          final ticker = CoinbaseTicker.fromMap(decoded);

          if (ticker.productId.isEmpty || ticker.price == null) {
            continue;
          }

          reconnectDelay = const Duration(seconds: 1);
          yield ticker;
        }

        throw StateError('Coinbase WebSocket connection closed.');
      } catch (_) {
        await Future<void>.delayed(reconnectDelay);

        final nextDelay = reconnectDelay * 2;
        reconnectDelay = nextDelay > const Duration(seconds: 30)
            ? const Duration(seconds: 30)
            : nextDelay;
      } finally {
        await channel?.sink.close();
      }
    }
  }

  Stream<List<MarketSnapshot>> streamMarkets() async* {
    final currentMarkets = <MarketSnapshot>[
      ...await _getCachedCoinGeckoMarkets(),
    ];

    yield List<MarketSnapshot>.unmodifiable(currentMarkets);

    final products = await getCoinbaseUsdProducts();

    final matches = matchCoinbaseProductsToMarkets(
      markets: currentMarkets,
      products: products,
    );

    if (matches.isEmpty) {
      return;
    }

    final marketIndexesById = <String, int>{};

    for (var index = 0; index < currentMarkets.length; index++) {
      final marketId = currentMarkets[index].id;

      if (marketId != null && marketId.isNotEmpty) {
        marketIndexesById[marketId] = index;
      }
    }

    await for (final ticker in streamCoinbasePrices(
      productIds: matches.keys.toList(growable: false),
    )) {
      final matchedMarket = matches[ticker.productId];
      final marketId = matchedMarket?.id;

      if (marketId == null) {
        continue;
      }

      final index = marketIndexesById[marketId];

      if (index == null || ticker.price == null) {
        continue;
      }

      final oldMarket = currentMarkets[index];

      final percentageChange = _calculate24HourChange(
        currentPrice: ticker.price!,
        openingPrice: ticker.open24h,
        fallback: oldMarket.priceChangePercentage24h,
      );

      currentMarkets[index] = oldMarket.copyWith(
        currentPrice: ticker.price,
        high24h: ticker.high24h ?? oldMarket.high24h,
        low24h: ticker.low24h ?? oldMarket.low24h,
        totalVolume: ticker.volume24h ?? oldMarket.totalVolume,
        priceChangePercentage24h: percentageChange,
        lastUpdated: ticker.time ?? DateTime.now().toUtc(),
      );

      yield List<MarketSnapshot>.unmodifiable(currentMarkets);
    }
  }

  Future<List<MarketSnapshot>> _getCoinGeckoPage({
    required int page,
    required int perPage,
  }) async {
    late final Response<List<dynamic>> response;

    try {
      response = await dio.get<List<dynamic>>(
        '$_coinGeckoBaseUrl/coins/markets',
        queryParameters: {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': perPage,
          'page': page,
          'sparkline': true,
          'price_change_percentage': '24h',
        },
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 429) {
        throw StateError(
          'CoinGecko rate limit reached. Add a CoinGecko API key and retry.',
        );
      }

      rethrow;
    }

    return (response.data ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(MarketSnapshot.fromCoinGecko)
        .toList(growable: false);
  }

  void dispose() {
    dio.close(force: true);
  }
}
