import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black26),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withValues(alpha: .1),
                        //     blurRadius: 10,
                        //     offset: Offset(0, 5),
                        //   ),
                        //   BoxShadow(
                        //     color: Colors.black.withValues(alpha: .1),
                        //     blurRadius: 10,
                        //     offset: Offset(0, 5),
                        //   ),
                        // ],
                      ),
                      alignment: .center,
                      child: SvgPicture.asset(
                        'assets/svgs/ui/icon-notification-bell.svg',
                        height: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
