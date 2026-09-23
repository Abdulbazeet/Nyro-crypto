import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyro_cryto/common/app_utils.dart';
import 'package:nyro_cryto/features/auth_screens/services/auth_service.dart';

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
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20).copyWith(top: 30),
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
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 12,
                                      color: Colors.black38,
                                      fontWeight: .bold,
                                    ),
                                  ),

                                  Text(
                                    user.whenOrNull(
                                          data: (data) => data!.username ?? '',
                                          error: (error, stackTrace) => 'User',
                                          loading: () => 'User',
                                        ) ??
                                        '',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: .bold,
                                    ),
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
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: .bold,
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
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: .7),
                                  fontWeight: .bold,
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
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: .bold,
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
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: .bold,
                                    ),
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
                            Text(
                              'Your holdings',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'See wallet',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'No assets owned yet',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                            textAlign: .center,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              'Market snapshot',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'See all',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
