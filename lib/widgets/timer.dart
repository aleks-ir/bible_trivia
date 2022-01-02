import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final AnimationController timerController;
  final String time;
  final Color indicatorColor;
  final Color textColor;

  const TimerWidget({
    Key? key,
    required this.timerController,
    required this.time,
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
            color: Colors.teal,
            //color: Colors.green.shade200,
          )),
        ),
        AnimatedBuilder(
            animation: timerController,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  time,
                  style: TextStyle(fontSize: 18.0, color: textColor),
                ),
              );
            }),
      ],
    );
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

    //canvas.drawCircle(size.center(Offset(0, -15)), size.width / 2.0, paint);
    canvas.drawArc(Offset(0, -15) & size, 0, math.pi, false, paint);
    paint.color = color;
    double progress = (0 + animation.value) * math.pi;
    canvas.drawArc(Offset(0, -15) & size, math.pi, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
