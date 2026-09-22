import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nyro_cryto/features/activity/screen/activity.dart';
import 'package:nyro_cryto/features/home/screen/home.dart';
import 'package:nyro_cryto/features/main-screen/widget/bottom_bar.dart';
import 'package:nyro_cryto/features/market/screen/market.dart';
import 'package:nyro_cryto/features/profile/screen/profile.dart';
import 'package:nyro_cryto/features/wallet/screen/wallet.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  List<Widget> screens = [
    const Home(),
    const Market(),
    const Wallet(),
    const Activity(),
    const Profile(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: screens[currentIndex]),
            Align(
              alignment: .bottomCenter,
              child: BottomBar(
                currentIndex: currentIndex,
                onTap: (p0) {
                  setState(() {
                    currentIndex = p0;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
