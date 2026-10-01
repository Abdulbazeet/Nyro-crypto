import 'package:flutter/material.dart';

class MarketShimmer extends StatefulWidget {
  const MarketShimmer({super.key});

  @override
  State<MarketShimmer> createState() => _MarketShimmerState();
}

class _MarketShimmerState extends State<MarketShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final offset = _controller.value * 2 - 1;
            return LinearGradient(
              begin: Alignment(offset - 1, 0),
              end: Alignment(offset + 1, 0),
              colors: [Color(0xFFE9E9E9), Color(0xFFF7F7F7), Color(0xFFE9E9E9)],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        child: Column(
          children: [
            for (var index = 0; index < 7; index++)
              Container(
                height: 72,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
