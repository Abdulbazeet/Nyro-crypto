import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nyro_cryto/common/app_utils.dart';
import 'package:nyro_cryto/features/auth_screens/services/auth_service.dart';
import 'package:nyro_cryto/features/home/widget/market_snapshot_list.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  String greetings() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  List tabsTiles = [
    (
      icons: "assets/svgs/actions/action-buy.svg",
      boxColor: Colors.green.withValues(alpha: .1),
      text: "Buy",
      color: Colors.green,
    ),
    (
      icons: "assets/svgs/actions/action-sell.svg",
      boxColor: Colors.red.withValues(alpha: .1),
      text: "Sell",
      color: Colors.red,
    ),
    (
      icons: "assets/svgs/actions/action-deposit.svg",
      boxColor: Colors.blue.withValues(alpha: .1),
      text: "Deposit",
      color: Colors.blue,
    ),
    (
      icons: "assets/svgs/actions/action-withdraw.svg",
      boxColor: Colors.blue.withValues(alpha: .1),
      text: "Withdraw",
      color: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 100).copyWith(top: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: .start,

                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    greetings(),
                                    style: textTheme.labelMedium,
                                  ),

                                  Text(
                                    user.whenOrNull(
                                          data: (data) => data!.username ?? '',
                                          error: (error, stackTrace) => 'User',
                                          loading: () => 'User',
                                        ) ??
                                        '',
                                    style: textTheme.headlineSmall,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    //color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.black26),
                                  ),
                                  alignment: .center,
                                  child: SvgPicture.asset(
                                    'assets/svgs/ui/icon-notification-bell.svg',
                                    height: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: .1,
                                        ),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: .1,
                                        ),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  alignment: .center,
                                  child: Text(
                                    user.whenOrNull(
                                          data: (data) =>
                                              data!.username
                                                  ?.substring(0, 1)
                                                  .toUpperCase() ??
                                              '',
                                          error: (error, stackTrace) => 'U',
                                          loading: () => 'U',
                                        ) ??
                                        '',
                                    style: textTheme.headlineSmall?.copyWith(
                                      color: colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40),

                        Container(
                          height: 100,
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.black.withValues(alpha: .8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: .start,
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                'Total portfolio value',
                                style: textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onPrimary.withValues(
                                    alpha: .7,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                user.whenOrNull(
                                      data: (data) => AppUtils.formatCurrency(
                                        data!.portfolioValue ?? 0.0,
                                        data.currency ?? 'USD',
                                      ),
                                      error: (error, stackTrace) => 'USD 0.00',
                                      loading: () => 'USD 0.00',
                                    ) ??
                                    'USD 0.00',
                                style: textTheme.headlineSmall?.copyWith(
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        for (int i = 0; i < 4; i++) ...[
                          if (i != 0) const SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: const Color(0xFFECEEF6),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                mainAxisAlignment: .center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: tabsTiles[i].boxColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      tabsTiles[i].icons,
                                      height: 16,
                                      color: tabsTiles[i].color,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    tabsTiles[i].text,
                                    style: textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text('Your holdings', style: textTheme.titleSmall),
                            Text('See wallet', style: textTheme.labelMedium),
                          ],
                        ),

                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'No assets owned yet',
                            style: textTheme.bodySmall,
                            textAlign: .center,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              'Market snapshot',
                              style: textTheme.titleSmall,
                            ),
                            Text('See all', style: textTheme.labelMedium),
                          ],
                        ),
                        const MarketSnapshotList(),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              'Recent activity',
                              style: textTheme.titleSmall,
                            ),
                            Text('See all', style: textTheme.labelMedium),
                          ],
                        ),
                         SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'No activity recorded yet',
                            style: textTheme.bodySmall,
                            textAlign: .center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
