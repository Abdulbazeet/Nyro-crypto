import 'package:flutter/material.dart';

class MarketSnapshotShimmer extends StatefulWidget {
  const MarketSnapshotShimmer({super.key});

  @override
  State<MarketSnapshotShimmer> createState() => _MarketSnapshotShimmerState();
}

class _MarketSnapshotShimmerState extends State<MarketSnapshotShimmer>
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
              colors: [
                theme.colorScheme.surfaceContainerHighest,
                theme.colorScheme.surface,
                theme.colorScheme.surfaceContainerHighest,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Column(
        children: [
          for (var index = 0; index < 5; index++)
            Container(
              height: 66,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
        ],
      ),
    );
  }
}
