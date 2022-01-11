import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/models/answer.dart';

class CheckBoxView extends StatelessWidget {
  final int questionId;
  final List<Answer> currentAnswers;
  final Function(bool?, int, int) callback;
  final Color cardColor;
  final Color textColor;
  final Color selectedColor;

  const CheckBoxView(this.questionId, this.currentAnswers, this.callback,
      {Key? key,
      this.cardColor = Colors.white,
      this.textColor = Colors.black,
      this.selectedColor = Colors.teal})
      : super(key: key);

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
              padding: const EdgeInsets.all(5.0),
              child: Builder(builder: (context) {
                return Theme(
                  data: Theme.of(context).copyWith(
                      textTheme: TextTheme(
                        subtitle1: TextStyle(color: textColor),
                      ),
                      unselectedWidgetColor: Colors.grey,
                      checkboxTheme: CheckboxThemeData(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),
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
              }),
            ),
          );
        });
  }
}
