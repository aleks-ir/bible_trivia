import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HomePainter extends CustomPainter {
  Color primaryColor;
  bool isPortrait;

  HomePainter(this.isPortrait, this.primaryColor);

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = primaryColor;
    canvas.drawPath(mainBackground, paint);


    Path ovalPathBottom = Path();
    ovalPathBottom.moveTo(0, height * 0.9);
    ovalPathBottom.quadraticBezierTo(
        width * 0.25, height * 0.8, width * 0.6, height * 0.9);
    ovalPathBottom.quadraticBezierTo(width * 0.6, height * 0.9, width, height);
    ovalPathBottom.lineTo(0, height);
    ovalPathBottom.close();

    if(isPortrait){
      paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(500, 0),
        [
          Colors.greenAccent,
          Colors.teal,
        ],
      );
      canvas.drawPath(ovalPathBottom, paint);


      Path ovalPathTop = Path();
      ovalPathTop.moveTo(width, height * 0.1);
      ovalPathTop.quadraticBezierTo(width * 0.75, height * 0.2, width * 0.4, height * 0.1);
      ovalPathTop.quadraticBezierTo(
          width * 0.4, height * 0.1, 0, 0);
      ovalPathTop.lineTo(width, 0);
      ovalPathTop.close();
      paint.shader = ui.Gradient.linear(
        Offset(500, 0), Offset(0, 0),
        [
          Colors.greenAccent,
          Colors.teal,
        ],
      );
      canvas.drawPath(ovalPathTop, paint);
    }



  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}