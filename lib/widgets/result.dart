import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/answer.dart';
import 'package:weekly_bible_trivia/models/firebase/question.dart';

class ResultView extends StatelessWidget {
  final List<Question> listQuestions;
  final List<List<Answer>> listUserAnswers;
  final List<List<Answer>> listCorrectAnswers;
  final List<String> listStateAnswers;
  final String language;
  final Color titleColor;
  final Color cardColor;
  final Color textColor;

  const ResultView(this.listQuestions, this.listUserAnswers,
      this.listCorrectAnswers, this.listStateAnswers, this.language,
      {Key? key, this.titleColor = Colors.black54,
        this.cardColor = Colors.white,
        this.textColor = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listQuestions.length,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        String titleQuestion = language == RUSSIAN
            ? listQuestions[index].questionRu
            : listQuestions[index].questionEn;
        List<String> titleAnswers = language == RUSSIAN
            ? listQuestions[index].answersRu
            : listQuestions[index].answersEn;
        List<Answer> userAnswers = listUserAnswers[index];
        List<Answer> correctAnswers = listCorrectAnswers[index];
        String title = question.i18n + " " + (index + 1).toString();

        return
          ExpandableNotifier(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 3),
                child: Card(
                  elevation: 2,
                  color: cardColor,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      ScrollOnExpand(
                        scrollOnExpand: true,
                        scrollOnCollapse: false,
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(
                            iconColor: _getIconColor(listStateAnswers[index]),
                            headerAlignment: ExpandablePanelHeaderAlignment.center,
                            tapBodyToCollapse: true,
                          ),
                          header: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              title,
                              style: TextStyle(fontFamily: VERDANA,
                                  fontSize: 15, color: textColor),
                            ),
                          ),
                          collapsed: const SizedBox.shrink(),
                          expanded:
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  child: Text(
                                    titleQuestion,
                                    style: TextStyle(fontFamily: VERDANA, fontSize: 14, color: textColor),
                                  ),
                                ),
                                for (int i = 0; i < titleAnswers.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                    child: Text(
                                      titleAnswers[i],
                                      style: TextStyle(
                                          fontFamily: VERDANA,
                                          color: _getAnswerColor(userAnswers[i].isSelected,
                                              correctAnswers[i].isSelected)),
                                    ),
                                  ),
                                const SizedBox(height: 30,)
                              ],
                            ),
                          ),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2, top: 2),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                                theme: const ExpandableThemeData(crossFadePoint: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));

      },
    );
  }

  Color _getIconColor(String stateAnswer) {
    if (stateAnswer == CORRECT) {
      return Colors.lightGreen;
    } else if (stateAnswer == WRONG) {
      return Colors.redAccent;
    } else {
      return Colors.grey;
    }
  }

  Color _getAnswerColor(bool userAnswer, bool correctAnswer) {
    if (correctAnswer) {
      return Colors.lightGreen;
    } else if (userAnswer != correctAnswer) {
      return Colors.redAccent;
    } else {
      return Colors.grey;
    }
  }
}