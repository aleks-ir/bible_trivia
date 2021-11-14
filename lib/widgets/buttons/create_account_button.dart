import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final Function() onPressed;

  CreateAccountButton({
    required this.onPressed,
  });

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black45,
    padding: EdgeInsets.all(12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  );
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: this.onPressed,
        child: Text(
          "Create Account",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
