import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/text_styles.dart';

Widget authTextField(
    {required bool obscure, required bool autofocus, required String label, required IconData icon, required TextEditingController controller, required Function(String) onChanged}) {
  return TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: autofocus,
      style: TextStyles.signInInputTextStyle,
      obscureText: obscure,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      )
  );
}

