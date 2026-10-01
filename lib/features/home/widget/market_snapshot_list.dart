import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nyro_cryto/features/market/service/market_notifier.dart';
import 'package:nyro_cryto/features/home/widget/market_snapshot_shimmer.dart';
import 'package:nyro_cryto/features/home/widget/market_snapshot_tile.dart';

class MarketSnapshotList extends ConsumerWidget {
  const MarketSnapshotList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketState = ref.watch(marketMarketsProvider);
    final textTheme = Theme.of(context).textTheme;

    return marketState.when(
      loading: () => const Column(
        children: [SizedBox(height: 24), MarketSnapshotShimmer()],
      ),
      error: (error, stackTrace) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Text('Market data unavailable', style: textTheme.bodySmall),
        ),
      ),
      data: (markets) {
        final visibleMarkets = markets.take(10).toList();

        return Column(
          children: [
            if (visibleMarkets.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'No market data available',
                    style: textTheme.bodySmall,
                  ),
                ),
              )
            else
              for (final market in visibleMarkets)
                MarketSnapshotTile(market: market),
          ],
        );
      },
    );
  }
}
