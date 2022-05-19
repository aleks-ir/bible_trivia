import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackground extends StatelessWidget {

  const BlurBackground({
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}