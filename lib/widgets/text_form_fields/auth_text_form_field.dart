import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/constants/colors.dart';
import 'package:weekly_bible_trivia/constants/text_styles.dart';

Widget authTextField(
    {required bool obscure, required bool autofocus, required String label, required IconData icon}) {
  return TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: autofocus,
      style: TextStyles.signInInputTextStyle,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      )
  );
}

Widget emailError(String emailError) =>
    Padding(
      padding: EdgeInsets.only(left: 65.0, right: 65.0, top: 2.0),
      child: new Text(emailError,
        style: TextStyle(
            fontSize: 10.0,
            color: Color(error_red)
        ),
      ),
    );

Widget passwordError(String passwordError) =>
    Padding(
      padding: EdgeInsets.only(left: 65.0, right: 65.0, top: 2.0),
      child: new Text(passwordError,
        style: TextStyle(
            fontSize: 10.0,
            color: Color(error_red)
        ),
      ),
    );
