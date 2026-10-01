import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nyro_cryto/common/app_utils.dart';
import 'package:nyro_cryto/features/home/widget/market_initial.dart';
import 'package:nyro_cryto/features/home/widget/market_trend_painter.dart';
import 'package:nyro_cryto/model/market_snapshot.dart';

class MarketSnapshotTile extends StatelessWidget {
  const MarketSnapshotTile({required this.market, super.key});

  final MarketSnapshot market;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final changeIsPositive = market.priceChangePercentage24h! >= 0;
    final changeColor = changeIsPositive
        ? Colors.green
        : theme.colorScheme.error;
    final changePrefix = changeIsPositive ? '+' : '';
    final marketInitial = market.symbol!.isEmpty
        ? '?'
        : market.symbol!.substring(0, 1);

    return GestureDetector(
      onTap: () {
        context.push('/home-market', extra: market);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: .1),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: market.imageUrl!.isEmpty
                    ? MarketInitial(
                        initial: marketInitial,
                        colorScheme: theme.colorScheme,
                        textTheme: theme.textTheme,
                      )
                    : Image.network(
                        market.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            MarketInitial(
                              initial: marketInitial,
                              colorScheme: theme.colorScheme,
                              textTheme: theme.textTheme,
                            ),
                      ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(market.name!, style: theme.textTheme.bodyLarge),
                  Text(market.symbol!, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 54,
                height: 30,
                child: CustomPaint(
                  painter: MarketTrendPainter(
                    values: market.priceHistory!,
                    color: changeColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppUtils.formatCurrency(market.priceUsd!, 'USD'),
                  style: theme.textTheme.labelLarge,
                ),
                Text(
                  '$changePrefix${market.priceChangePercentage24h!.toStringAsFixed(2)}%',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: changeColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
