import 'package:nyro_cryto/model/market_snapshot.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'market_service.dart';

part 'market_notifier.g.dart';

@Riverpod(keepAlive: true)
MarketDataService marketDataService(Ref ref) {
  final coinGeckoApiKey = dotenv.env['COINGECKO_API_KEY'] ?? '';
  final service = MarketDataService(
    coinGeckoApiKey: coinGeckoApiKey.isEmpty ? null : coinGeckoApiKey,
  );

  ref.onDispose(service.dispose);

  return service;
}

@Riverpod(keepAlive: true)
Stream<List<MarketSnapshot>> marketMarkets(Ref ref) {
  final service = ref.watch(marketDataServiceProvider);

  return service.streamMarkets();
}
