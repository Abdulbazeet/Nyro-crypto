import 'package:nyro_cryto/features/home/service/market_service.dart';
import 'package:nyro_cryto/model/market_snapshot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifier.g.dart';

@riverpod
Stream<List<MarketSnapshot>> marketSnapshots(Ref ref) {
  return ref.watch(marketServiceProvider).streamMarketSnapshots();
}
