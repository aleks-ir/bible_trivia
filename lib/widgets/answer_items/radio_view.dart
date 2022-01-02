import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/answer.dart';

class RadioView extends StatelessWidget {
  int questionId;
  List<Answer> listTitleAnswers;
  Function(bool?, int, int) callback;
  Color cardColor;
  Color textColor;
  Color selectedColor;

  late Answer selectedAnswer;

  RadioView(this.questionId, this.listTitleAnswers, this.callback,
      {this.cardColor: Colors.white,
      this.textColor: Colors.black,
      this.selectedColor: Colors.teal});

  List<Widget> createRadioListAnswers() {
    var selectedAnswers =
        listTitleAnswers.where((element) => element.isSelected);
    selectedAnswer = selectedAnswers.length == 1
        ? selectedAnswers.first
        : Answer(answerId: -1, title: '');
    List<Widget> widgets = [];
    for (Answer answer in listTitleAnswers) {
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
    return SingleChildScrollView(
      child: Column(
        children: createRadioListAnswers(),
      ),
    );
  }
}
