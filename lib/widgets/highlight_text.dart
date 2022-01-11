import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final String text;
  final String highlight;
  final TextStyle style;
  final Color highlightColor;
  final Color textColor;

  const HighlightText({
    required this.text,
    required this.highlight,
    this.style = const TextStyle(),
    this.highlightColor = Colors.grey,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight = text.indexOf(highlight, start);
      if (indexOfHighlight < 0) {
        spans.add(_normalSpan(text.substring(start, text.length)));
        break;
      }
      if (indexOfHighlight == start) {
        spans.add(_highlightSpan(highlight));
        start += highlight.length;
      } else {
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
        spans.add(_highlightSpan(highlight));
        start = indexOfHighlight + highlight.length;
      }
    } while (true);

    return Text.rich(TextSpan(children: spans), style: TextStyle(color: textColor));
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(
        text: content, style: style.copyWith(color: highlightColor));
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: style);
  }
}
