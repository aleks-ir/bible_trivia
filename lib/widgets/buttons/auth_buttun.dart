import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Function() onPressed;
  final Color colorButton;
  final EdgeInsets padding;
  final double borderRadius;
  
  AuthButton({
    required this.text,
    required this.textStyle,
    required this.onPressed,
    required this.colorButton,
    required this.padding,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: this.colorButton,
          //onPrimary: Colors.black45,
          padding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
          ),
        ),
        onPressed: this.onPressed,
        child: Text(
          this.text,
          style: this.textStyle,
        ),
      ),
    );
  }
}


MaterialButton authButton(String title, VoidCallback callback,
    {Color color: const Color(0xfff063057), Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: callback,
    textColor: textColor,
    color: color,
    child: SizedBox(
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}