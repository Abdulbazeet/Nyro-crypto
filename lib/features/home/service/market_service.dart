import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nyro_cryto/model/market_snapshot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'market_service.g.dart';

@riverpod
MarketService marketService(Ref ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  ref.onDispose(dio.close);
  return MarketService(dio);
}

class MarketService {
  MarketService(this._dio);

  final Dio _dio;

  static const _coinGeckoBaseUrl = 'https://api.coingecko.com/api/v3';
  static const _coinbaseProductsUrl = 'https://api.exchange.coinbase.com';
  static const _coinbaseWebSocketUrl = 'wss://ws-feed.exchange.coinbase.com';

  Future<List<MarketSnapshot>> getMarketSnapshotPreview() async {
    final response = await _dio.get<List<dynamic>>(
      '$_coinGeckoBaseUrl/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': 20,
        'page': 1,
        'sparkline': true,
        'price_change_percentage': '24h',
      },
    );

    return (response.data ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(_snapshotFromMarket)
        .toList(growable: false);
  }

  Future<List<MarketSnapshot>> getMarketSnapshots() async {
    const perPage = 250;
    final snapshots = <MarketSnapshot>[];
    var page = 1;

    while (true) {
      final response = await _dio.get<List<dynamic>>(
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
      final markets = response.data ?? const <dynamic>[];

      snapshots.addAll(
        markets.whereType<Map<String, dynamic>>().map(_snapshotFromMarket),
      );

      if (markets.length < perPage) {
        return snapshots;
      }
      page++;
    }
  }

  Stream<List<MarketSnapshot>> streamMarketSnapshots() async* {
    final loadingStartedAt = DateTime.now();
    final snapshots = await getMarketSnapshotPreview();
    const minimumLoadingDuration = Duration(milliseconds: 400);
    final elapsed = DateTime.now().difference(loadingStartedAt);
    final remaining = minimumLoadingDuration - elapsed;
    if (remaining > Duration.zero) {
      await Future<void>.delayed(remaining);
    }
    yield snapshots;

    late final Map<String, String> productSymbols;
    try {
      productSymbols = await _getCoinbaseUsdProducts();
    } catch (_) {
      return;
    }

    var liveSnapshots = List<MarketSnapshot>.of(snapshots);
    final snapshotIndexesBySymbol = <String, int>{};
    for (var index = 0; index < liveSnapshots.length; index++) {
      snapshotIndexesBySymbol.putIfAbsent(
        liveSnapshots[index].symbol,
        () => index,
      );
    }
    final products = productSymbols.entries
        .where((entry) => snapshotIndexesBySymbol.containsKey(entry.value))
        .map((entry) => entry.key)
        .toList();

    if (products.isEmpty) {
      return;
    }

    final channel = WebSocketChannel.connect(Uri.parse(_coinbaseWebSocketUrl));

    try {
      channel.sink.add(
        jsonEncode({
          'type': 'subscribe',
          'product_ids': products,
          'channels': ['ticker'],
        }),
      );

      await for (final message in channel.stream) {
        if (message is! String) {
          continue;
        }

        final ticker = jsonDecode(message);
        if (ticker is! Map<String, dynamic> || ticker['type'] != 'ticker') {
          continue;
        }

        final productId = ticker['product_id'] as String?;
        final price = double.tryParse(ticker['price']?.toString() ?? '');
        final symbol = productId == null ? null : productSymbols[productId];
        final index = symbol == null ? null : snapshotIndexesBySymbol[symbol];
        final snapshot = index == null ? null : liveSnapshots[index];

        if (snapshot == null || index == null || price == null) {
          continue;
        }

        liveSnapshots[index] = snapshot.copyWith(
          priceUsd: price,
          updatedAt: DateTime.now().toUtc(),
        );
        yield List<MarketSnapshot>.unmodifiable(liveSnapshots);
      }
    } finally {
      await channel.sink.close();
    }
  }

  Future<Map<String, String>> _getCoinbaseUsdProducts() async {
    final response = await _dio.get<List<dynamic>>(
      '$_coinbaseProductsUrl/products',
    );

    return {
      for (final product in response.data ?? const <dynamic>[])
        if (product is Map<String, dynamic> &&
            product['quote_currency'] == 'USD' &&
            product['status'] == 'online' &&
            product['id'] is String &&
            product['base_currency'] is String)
          product['id'] as String: (product['base_currency'] as String)
              .toUpperCase(),
    };
  }

  MarketSnapshot _snapshotFromMarket(Map<String, dynamic> market) {
    final price = (market['current_price'] as num?)?.toDouble();
    if (price == null) {
      throw const FormatException(
        'Market response did not contain a valid price',
      );
    }

    return MarketSnapshot(
      id: market['id'] as String? ?? '',
      symbol: (market['symbol'] as String? ?? '').toUpperCase(),
      name: market['name'] as String? ?? '',
      imageUrl: market['image'] as String? ?? '',
      priceUsd: price,
      priceChangePercentage24h:
          (market['price_change_percentage_24h'] as num?)?.toDouble() ?? 0,
      priceHistory:
          ((market['sparkline_in_7d'] as Map<String, dynamic>?)?['price']
                      as List<dynamic>? ??
                  const [])
              .whereType<num>()
              .map((value) => value.toDouble())
              .toList(growable: false),
      updatedAt: DateTime.now().toUtc(),
    );
  }
}
