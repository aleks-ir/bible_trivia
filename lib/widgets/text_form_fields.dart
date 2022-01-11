import 'package:flutter/material.dart';

Widget authTextField(
    {bool obscure = false,
    bool autofocus = false,
    Color textColor = Colors.black,
    Color borderColor = Colors.black,
    Color focusedBorderColor = Colors.black,
    IconData? icon,
    String label = '',
    required TextEditingController controller,
    required Function(String) onChanged}) {
  return TextField(
      cursorColor: focusedBorderColor,
      keyboardType: TextInputType.emailAddress,
      autofocus: autofocus,
      style: TextStyle(
        fontSize: 15,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      obscureText: obscure,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 15,
          color: textColor,
        ),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: textColor,
                size: 20,
              )
            : null,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(width: 2, color: focusedBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide:  BorderSide(color: borderColor, width: 1.0),
        ),
      )
  );
}


Widget searchTextField(
    {Color textColor = Colors.black,
      Color borderColor = Colors.black,
      required TextEditingController controller,
      required Function() callback}) {
  return TextField(
      onEditingComplete: callback,
      cursorColor: borderColor,
      style: TextStyle(
        fontSize: 17,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1.5, color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: borderColor),
        ),
      )
  );
}

