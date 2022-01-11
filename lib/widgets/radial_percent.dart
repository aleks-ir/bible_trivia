import 'dart:ui';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadialPercentWidget extends StatelessWidget {

  final AnimationController controller;
  final double percentCorrect;
  final double percentWrong;
  final Color textColor;
  final Color fillColor;
  final Color correctColor;
  final Color wrongColor;
  final Color skippedColor;
  final double lineWidth;

  const RadialPercentWidget({
    Key? key,
    required this.controller,
    required this.percentCorrect,
    required this.percentWrong,
    this.textColor: Colors.black,
    this.fillColor: Colors.black,
    this.correctColor: Colors.lightGreen,
    this.wrongColor: Colors.redAccent,
    this.skippedColor: Colors.grey,
    this.lineWidth: 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: RadialPercentPainter(
            animation: controller,
            percentCorrect: percentCorrect,
            percentWrong: percentWrong,
            fillColor: fillColor,
            correctColor: correctColor,
            wrongColor: wrongColor,
            skippedColor: skippedColor,
            lineWidth: lineWidth,
          ),
        ),
        AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Center(
                child: Text(
                  _getPercentString(),
                  style: TextStyle(fontSize: 20.0, color: textColor),
                ),
              );
            }),
      ],
    );
  }

  String _getPercentString() {
    int currentPercent = 0;
    currentPercent = (controller.value * percentCorrect * 100).toInt();
    return '$currentPercent%';
  }
}

class RadialPercentPainter extends CustomPainter {
  final Animation<double> animation;
  final double percentCorrect;
  final double percentWrong;
  final Color fillColor;
  final Color correctColor;
  final Color wrongColor;
  final Color skippedColor;
  final double lineWidth;

  RadialPercentPainter({
    required this.animation,
    required this.percentCorrect,
    required this.percentWrong,
    required this.fillColor,
    required this.correctColor,
    required this.wrongColor,
    required this.skippedColor,
    required this.lineWidth,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final arcRect = calculateArcsRect(size);
    drawBackground(canvas, size);
    drawSkippedArc(canvas, arcRect);

    drawCorrectArc(canvas, arcRect);
    drawWrongArc(canvas, arcRect);
  }

  void drawSkippedArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = skippedColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;

    canvas.drawArc(
      arcRect,
      -pi / 2,
      pi * 2,
      false,
      paint,
    );
  }

  void drawCorrectArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = correctColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    paint.strokeCap = StrokeCap.round;


    double progress = (animation.value) * (percentCorrect + percentWrong) * 2 * pi;
    canvas.drawArc(
      arcRect,
      -pi / 2,
      -progress,
      false,
      paint,
    );
  }

  void drawWrongArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = wrongColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    paint.strokeCap = StrokeCap.round;

    double progress = (animation.value) * percentWrong * 2 * pi;
    canvas.drawArc(
      arcRect,
      -pi / 2,
      -progress,
      false,
      paint,
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = fillColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcsRect(Size size) {
    const linesMargin = 5;
    final offest = lineWidth / 2 + linesMargin;
    final arcRect = Offset(offest, offest) &
    Size(size.width - offest * 2, size.height - offest * 2);
    return arcRect;
  }

  @override
  bool shouldRepaint(RadialPercentPainter old) {
    return animation.value != old.animation.value ||
        percentCorrect != old.percentCorrect ||
        percentWrong != old.percentWrong ||
        fillColor != old.fillColor ||
        correctColor != old.correctColor ||
        wrongColor != old.wrongColor ||
        skippedColor != old.skippedColor ||
        lineWidth != old.lineWidth;
  }
}