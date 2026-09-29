import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nyro_cryto/common/app_utils.dart';
import 'package:nyro_cryto/features/home/widget/market_initial.dart';
import 'package:nyro_cryto/model/market_snapshot.dart';

class HomeMarket extends ConsumerStatefulWidget {
  final MarketSnapshot market;

  const HomeMarket({super.key, required this.market});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeMarketState();
}

class _HomeMarketState extends ConsumerState<HomeMarket> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final changeIsPositive = widget.market.priceChangePercentage24h >= 0;
    final changeColor = changeIsPositive
        ? Colors.green
        : theme.colorScheme.error;
    final changePrefix = changeIsPositive ? '+' : '';
    final marketInitial = widget.market.symbol.isEmpty
        ? '?'
        : widget.market.symbol[0];

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black26),
                        ),
                        alignment: .center,
                        child: SvgPicture.asset(
                          'assets/svgs/ui/icon-back-arrow.svg',
                          height: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black26),
                      ),
                      alignment: .center,
                      child: SvgPicture.asset(
                        'assets/svgs/ui/icon-star-watchlist.svg',
                        height: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: widget.market.imageUrl.isEmpty
                          ? MarketInitial(
                              initial: marketInitial,
                              colorScheme: theme.colorScheme,
                              textTheme: theme.textTheme,
                            )
                          : Image.network(
                              widget.market.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  MarketInitial(
                                    initial: marketInitial,
                                    colorScheme: theme.colorScheme,
                                    textTheme: theme.textTheme,
                                  ),
                            ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            widget.market.name,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: .bold,
                            ),
                          ),
                          Text(
                            widget.market.symbol,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  AppUtils.formatCurrency(widget.market.priceUsd, 'USD'),
                  style: theme.textTheme.labelLarge?.copyWith(),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: changeColor.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$changePrefix${widget.market.priceChangePercentage24h.toStringAsFixed(2)}%',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: changeColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
