import 'package:flutter/material.dart';

Widget authTextField(
    {bool obscure: false, bool autofocus: false, Color color: Colors.black, IconData? icon : null, String label: '', required TextEditingController controller, required Function(String) onChanged}) {
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
        prefixIcon: icon != null ? Icon(icon, color: color) : null,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      )
  );
}

