import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/answer.dart';

class RadioView extends StatelessWidget {
  final int questionId;
  final List<Answer> currentAnswers;
  final Function(bool?, int, int) callback;
  final Color cardColor;
  final Color textColor;
  final Color selectedColor;

  late Answer selectedAnswer;

  RadioView(this.questionId, this.currentAnswers, this.callback,
      {Key? key, this.cardColor = Colors.white,
      this.textColor = Colors.black,
      this.selectedColor = Colors.teal}) : super(key: key);

  List<Widget> createRadioListAnswers() {
    List<Widget> widgets = [];
    for (Answer answer in currentAnswers) {
      widgets.add(
        Card(
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Builder(builder: (context) {
              return Theme(
                data: Theme.of(context).copyWith(
                  textTheme: TextTheme(
                    subtitle1: TextStyle(color: textColor),
                  ),
                  unselectedWidgetColor: Colors.grey
                ),
                child: RadioListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  value: answer,
                  groupValue: selectedAnswer,
                  title: Text(
                    answer.title,
                  ),
                  onChanged: (Answer? currentAnswer) {
                    callback(null, questionId, currentAnswer!.answerId);
                  },
                  selected: selectedAnswer == answer,
                  tileColor: cardColor,
                  activeColor: selectedColor,
                ),
              );
            }),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    var selectedAnswers =
    currentAnswers.where((element) => element.isSelected);
    selectedAnswer = selectedAnswers.length == 1
        ? selectedAnswers.first
        : Answer(answerId: -1, title: '');
    return SingleChildScrollView(
      child: Column(
        children: createRadioListAnswers(),
      ),
    );
  }
}
