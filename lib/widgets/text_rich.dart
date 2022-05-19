import 'package:flutter/cupertino.dart';
import 'package:weekly_bible_trivia/global/constants.dart';

class TextReader extends StatelessWidget {
  final int index;
  final bool isSearchVerse;
  final String text;
  final double fontSize;
  final Color? textColor;
  final Color? textSearchColor;
  const TextReader({
    required this.index,
    required this.isSearchVerse,
    required this.text,
    this.fontSize = 15,
    this.textColor,
    this.textSearchColor,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                (index + 1).toString() + " ",
                style: TextStyle(
                    color: textColor,
                    fontSize: fontSize - 8,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          TextSpan(
            text: text,
            style: TextStyle(
                fontSize: fontSize,
                color: isSearchVerse ? textSearchColor : textColor,
                fontWeight: FontWeight.normal,
                fontFamily: VERDANA),
          ),
        ],
      ),
    );
  }
}

