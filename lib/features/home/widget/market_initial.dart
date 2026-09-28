import 'package:flutter/material.dart';

class MarketInitial extends StatelessWidget {
  const MarketInitial({
    required this.initial,
    required this.colorScheme,
    required this.textTheme,
    super.key,
  });

  final String initial;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colorScheme.primaryContainer,
      child: Center(child: Text(initial, style: textTheme.labelLarge)),
    );
  }
}
