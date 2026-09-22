import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(20).copyWith(top: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
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
                                  color: Colors.black.withValues(alpha: .1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: .1),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
