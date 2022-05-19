import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final AnimationController timerController;
  final Color indicatorColor;
  final Color textColor;

  const TimerWidget({
    Key? key,
    required this.timerController,
    required this.indicatorColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: CustomPaint(
              painter: TimerPainter(
            animation: timerController,
            backgroundColor: Colors.grey.shade200,
            color: indicatorColor,
          )),
        ),
        AnimatedBuilder(
            animation: timerController,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  _getTimerString(),
                  style: TextStyle(fontSize: 18.0, color: textColor),
                ),
              );
            }),
      ],
    );
  }
  String _getTimerString() {
    Duration duration = timerController.duration! * timerController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(const Offset(0, -15) & size, 0, pi, false, paint);
    paint.color = color;
    double progress = (animation.value) * pi;
    canvas.drawArc(const Offset(0, -15) & size, pi, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
