import 'package:flutter/material.dart';

class MarketTrendPainter extends CustomPainter {
  const MarketTrendPainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;

    final minimum = values.reduce((a, b) => a < b ? a : b);
    final maximum = values.reduce((a, b) => a > b ? a : b);
    final range = maximum - minimum;
    final path = Path();

    for (var index = 0; index < values.length; index++) {
      final x = index / (values.length - 1) * size.width;
      final normalized = range == 0 ? .5 : (values[index] - minimum) / range;
      final y = size.height - normalized * size.height;

      if (index == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 1.4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant MarketTrendPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.color != color;
  }
}
