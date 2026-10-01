import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nyro_cryto/features/market/service/market_notifier.dart';
import 'package:nyro_cryto/features/market/widget/market_list.dart';

class Market extends ConsumerWidget {
  const Market({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketState = ref.watch(marketMarketsProvider);

    return Scaffold(
      body: SafeArea(
        child: MarketList(
          marketState: marketState,
          onRefresh: () async {
            ref.invalidate(marketMarketsProvider);
            await ref.read(marketMarketsProvider.future);
          },
        ),
      ),
    );
  }
}
