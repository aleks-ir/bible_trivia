import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final IconData? icon;
  final String label;
  final String error;
  final bool obscure;
  final bool autofocus;
  final Color? textColor;
  final Color borderColor;
  final Color focusedBorderColor;

  const AuthTextField(
      {required this.controller,
      required this.onChanged,
      this.icon,
      this.label = '',
      this.error = '',
      this.obscure = false,
      this.autofocus = false,
      this.textColor,
      this.borderColor = Colors.white,
      this.focusedBorderColor = Colors.white,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
        TextField(
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
                borderSide: BorderSide(width: 1.5, color: focusedBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: borderColor, width: 1.0),
              ),
            )),
        error.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  error,
                  style: const TextStyle(
                      fontSize: 10.0, color: Color(AppColors.error_red)),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}


class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final bool autofocus;
  final Color? textColor;
  final Color borderColor;
  final Color focusedBorderColor;

  const SearchTextField(
      {required this.controller,
        required this.onSubmitted,
        this.autofocus = false,
        this.textColor,
        this.borderColor = Colors.white,
        this.focusedBorderColor = Colors.white,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            cursorColor: focusedBorderColor,
            autofocus: autofocus,
            style: TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
            controller: controller,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              isDense: true,                      // Added this
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: focusedBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: borderColor, width: 1.0),
              ),
            )),
      ],
    );
  }
}


