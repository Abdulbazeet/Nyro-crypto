import 'package:flutter/material.dart';
import 'package:nyro_cryto/common/app_utils.dart';
import 'package:nyro_cryto/features/market/widget/market_initial.dart';
import 'package:nyro_cryto/features/market/widget/market_trend_painter.dart';
import 'package:nyro_cryto/model/market_snapshot.dart';

class MarketTile extends StatelessWidget {
  const MarketTile({required this.market, this.onTap, super.key});

  final MarketSnapshot market;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final change = market.priceChangePercentage24h ?? 0;
    final changeColor = change >= 0 ? Colors.green : theme.colorScheme.error;
    final symbol = market.symbol?.toUpperCase() ?? '?';
    final initial = symbol.isEmpty ? '?' : symbol.substring(0, 1);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
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
                child: market.imageUrl == null || market.imageUrl!.isEmpty
                    ? MarketInitial(initial: initial)
                    : Image.network(
                        market.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            MarketInitial(initial: initial),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    market.name ?? symbol,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(symbol, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            SizedBox(
              width: 54,
              height: 30,
              child: CustomPaint(
                painter: MarketTrendPainter(
                  values: market.priceHistory ?? const [],
                  color: changeColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 78,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatPrice(market.currentPrice),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge,
                  ),
                  Text(
                    '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: changeColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double? price) {
    if (price == null) return '-';
    return AppUtils.formatCurrency(price, 'USD');
  }
}
