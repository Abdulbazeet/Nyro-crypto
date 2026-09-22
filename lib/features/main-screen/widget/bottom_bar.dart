import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final Function(int) onTap;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static const _items = [
    (icon: "assets/svgs/navigation/tab-home.svg", label: 'Home'),
    (icon: "assets/svgs/navigation/tab-market.svg", label: 'Market'),
    (icon: "assets/svgs/navigation/tab-wallet.svg", label: 'Wallet'),
    (icon: "assets/svgs/navigation/tab-activity.svg", label: 'Activity'),
    (icon: "assets/svgs/navigation/tab-profile.svg", label: 'Profile'),
  ];

  bool? isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(25)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_items.length, (index) {
                setState(() {
                  isSelected = widget.currentIndex == index;
                });
                return GestureDetector(
                  onTap: () {
                    widget.onTap(index);
                  },
                  behavior: HitTestBehavior.opaque,

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      gradient: isSelected!
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.white, Colors.white],
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          _items[index].icon,
                          height: 18,

                          color: isSelected!
                              ? const Color(0xFF1A0D0D)
                              : Colors.white.withValues(alpha: .6),
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          child: isSelected!
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    _items[index].label,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
