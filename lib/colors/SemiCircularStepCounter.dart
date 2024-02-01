import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class SemiCircularStepCounter extends CustomPainter {
  final int steps;
  final int totalSteps;

  SemiCircularStepCounter({required this.steps, required this.totalSteps});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14,
      3.14 * 2,
      false,
      paint,
    );

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [AppColors.darkblue, AppColors.darkblue],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    double progressAngle = (steps / totalSteps) * (3.14 * 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

