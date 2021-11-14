import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function() text;

  CustomTextButton({
    required this.text,
  });

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.lightGreenAccent,
    padding: EdgeInsets.all(12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Forgot password?",
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}
