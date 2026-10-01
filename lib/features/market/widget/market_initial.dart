import 'package:flutter/material.dart';

class MarketInitial extends StatelessWidget {
  const MarketInitial({required this.initial, super.key});

  final String initial;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.colorScheme.primaryContainer,
      child: Center(child: Text(initial, style: theme.textTheme.labelLarge)),
    );
  }
}
