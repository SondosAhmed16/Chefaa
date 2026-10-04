import 'dart:math';

import 'package:chefaa/core/resources/color.dart';
import 'package:flutter/material.dart';

class HealthIndicator extends StatelessWidget {
  final int dangerScore;
  const HealthIndicator({super.key, required this.dangerScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorManager.gray, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 10,
            offset: Offset(2, 10),
          ),
        ],
      ),
      child: Center(
        child: CustomPaint(
          size: Size(220, 130),
          painter: _painter(score: dangerScore),
        ),
      ),
    );
  }
}

class _painter extends CustomPainter {
  final int score;

  _painter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 10);
    final radius = size.width / 2 - 10;
    const strokeWidth = 22.0;

    final paintArc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    paintArc.color = const Color(0xFF4CAF50);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi / 3,
      false,
      paintArc,
    );

    paintArc.color = const Color(0xFFFFD54F);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi + (pi / 3),
      pi / 3,
      false,
      paintArc,
    );

    paintArc.color = const Color(0xFFE53935);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi + (2 * pi / 3),
      pi / 3,
      false,
      paintArc,
    );

    final normalizedScore = (score.clamp(0, 5)) / 5.0;
    final needleAngle = pi + (normalizedScore * pi);

    final needlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;

    final needleLength = radius - 15;
    final needleEnd = Offset(
      center.dx + needleLength * cos(needleAngle),
      center.dy + needleLength * sin(needleAngle),
    );

    canvas.drawLine(center, needleEnd, needlePaint);
    canvas.drawCircle(center, 8, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
