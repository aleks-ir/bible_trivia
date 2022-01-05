import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/answer.dart';
import 'package:weekly_bible_trivia/models/firestore/question.dart';

import 'grids_view.dart';

ListView selectionListView(
    {required List<String> listBooks,
    required List<String> listDisplayBooks,
    required Map<String, int> mapCountChapters,
    required Function(String, int) callback,
    bool isPortrait: true,
    Color primaryColor: Colors.white,
    Color secondaryColor: Colors.black12,
    Color textColor: Colors.black}) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: listBooks.length,
    physics: ScrollPhysics(),
    itemBuilder: (context, index) {
      return Column(
        children: <Widget>[
          ExpandablePanel(
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              tapBodyToExpand: true,
              tapBodyToCollapse: true,
              hasIcon: false,
            ),
            header: Container(
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(listDisplayBooks[index],
                      style: TextStyle(color: textColor)),
                ),
              ),
            ),
            collapsed: Container(),
            expanded: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                height: isPortrait ? 200 : 100,
                child: selectionReaderGridView(
                    bookName: listBooks[index],
                    countChapters: mapCountChapters[listBooks[index]],
                    callback: callback,
                    secondaryColor: secondaryColor,
                    textColor: textColor),
              ),
            ),
          ),
        ],
      );
    },
  );
}

ListView translationListView(
    {required List<String> listTranslationsName,
    required List<String> listTranslationsId,
    required int indexSelectedTranslation,
    required Function(String) callback,
    Color primaryColor: Colors.white,
    Color noActiveTextColor: Colors.black38,
    Color activeTextColor: Colors.black}) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: listTranslationsName.length,
    physics: const ScrollPhysics(),
    itemBuilder: (context, index) {
      return Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: GestureDetector(
              onTap: () {
                callback(listTranslationsId[index]);
              },
              child: Text(listTranslationsName[index],
                  style: TextStyle(
                      color: indexSelectedTranslation != index
                          ? noActiveTextColor
                          : activeTextColor)),
            ),
          ),
        ),
      );
    },
  );
}

class ResultListView extends StatelessWidget {
  List<Question> listQuestions;
  List<List<Answer>> listUserAnswers;
  List<List<Answer>> listCorrectAnswers;
  List<String> listStateAnswers;
  String language;
  Color titleColor;
  Color cardColor;
  Color textColor;

  ResultListView(this.listQuestions, this.listUserAnswers,
      this.listCorrectAnswers, this.listStateAnswers, this.language,
      {this.titleColor: Colors.black54,
      this.cardColor: Colors.white,
      this.textColor: Colors.black});

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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Card(
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
                              style: TextStyle(fontFamily: INTER,
                                  fontSize: 18, color: textColor),
                            ),
                          ),
                          collapsed: SizedBox.shrink(),
                          expanded:
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  child: Text(
                                    titleQuestion,
                                    style: TextStyle(fontFamily: VERDANA,fontSize: 18, color: textColor),
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
                                SizedBox(height: 30,)
                              ],
                            ),
                          ),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding: EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 3),
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
