import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';

Widget authTextField(
    {bool obscure: false, bool autofocus: false, Color color: Colors.black,  required String label, required IconData icon, required TextEditingController controller, required Function(String) onChanged}) {
  return TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: autofocus,
      style: TextStyle(
        fontSize: 20,
        color: color,
        fontWeight: FontWeight.w400,
      ),
      obscureText: obscure,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 15,
          color: color,
        ),
        prefixIcon: Icon(icon, color: color),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      )
  );
}

