import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/answer.dart';

class CheckBoxView extends StatelessWidget {
  int questionId;
  List<Answer> currentAnswers;
  Function(bool?, int, int) callback;
  Color cardColor;
  Color textColor;
  Color selectedColor;

  CheckBoxView(this.questionId, this.currentAnswers, this.callback,
      {this.cardColor: Colors.white, this.textColor: Colors.black, this.selectedColor: Colors.teal});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: currentAnswers.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Builder(
                builder: (context) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      textTheme: TextTheme(
                        subtitle1: TextStyle(color: textColor),
                      ),
                      unselectedWidgetColor: Colors.grey,
                        checkboxTheme: CheckboxThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),)
                    ),
                    child: CheckboxListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: selectedColor,
                        checkColor: Colors.white,
                        selected: currentAnswers[index].isSelected,
                        title: Text(
                          currentAnswers[index].title,
                        ),
                        value: currentAnswers[index].isSelected,
                        onChanged: (val) {
                          callback(val, questionId, index);
                        }),
                  );
                }
              ),
            ),
          );
        });
  }
}
