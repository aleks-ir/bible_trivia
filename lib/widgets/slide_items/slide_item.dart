import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/answer.dart';
import 'package:weekly_bible_trivia/widgets/answer_items/check_box_view.dart';
import 'package:weekly_bible_trivia/widgets/answer_items/radio_view.dart';

class SlideItem extends StatelessWidget {
  final int questionId;
  final String questionTitle;
  final List<Answer> currentAnswers;
  final bool isCheckBox;
  final Function(bool?, int, int) callback;
  final Color? color;
  final Color? cardColor;
  final Color? textColor;
  final Color? selectedColor;

  const SlideItem(
      {Key? key, required this.questionId,
      required this.questionTitle,
      required this.currentAnswers,
      required this.isCheckBox,
      required this.callback,
      this.color,
      this.cardColor,
      this.textColor,
      this.selectedColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                color: color,
                margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 50, bottom: 30),
                  child: Text(
                    questionTitle,
                    style: TextStyle(
                        color: textColor, fontSize: 18, letterSpacing: 0.7),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 50.0, left: 15, right: 15),
              child: isCheckBox
                  ? CheckBoxView(
                      questionId,
                      currentAnswers,
                      callback,
                      cardColor: cardColor,
                      textColor: textColor,
                      selectedColor: selectedColor,
                    )
                  : RadioView(
                      questionId,
                      currentAnswers,
                      callback,
                      cardColor: cardColor,
                      textColor: textColor,
                      selectedColor: selectedColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
