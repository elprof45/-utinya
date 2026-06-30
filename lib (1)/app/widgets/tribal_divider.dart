import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A subtle zigzag + diamond divider, evoking tribal geometric borders.
class TribalDivider extends StatelessWidget {
  final Color color;
  final double height;
  final EdgeInsets margin;

  const TribalDivider({
    super.key,
    this.color = AppColors.ochre,
    this.height = 14,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _TribalPainter(color: color)),
    );
  }
}

class _TribalPainter extends CustomPainter {
  final Color color;
  _TribalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    final fillPaint = Paint()..color = color.withValues(alpha: 0.3);

    const double step = 18;
    final double midY = size.height / 2;

    double x = 0;
    final path = Path()..moveTo(0, midY);
    while (x < size.width) {
      path.lineTo(x + step / 2, midY - size.height / 2);
      path.lineTo(x + step, midY);
      x += step;
    }
    canvas.drawPath(path, linePaint);

    x = step / 4;
    while (x < size.width) {
      final diamond = Path()
        ..moveTo(x, midY - 3.5)
        ..lineTo(x + 3.5, midY)
        ..lineTo(x, midY + 3.5)
        ..lineTo(x - 3.5, midY)
        ..close();
      canvas.drawPath(diamond, fillPaint);
      x += step;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
