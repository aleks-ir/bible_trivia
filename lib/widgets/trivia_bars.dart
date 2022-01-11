import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/widgets/slide_items/slide_nums.dart';

Widget triviaTopBar({
  required String titleLeftButton,
  required String titleRightButton,
  required VoidCallback callbackLeftButton,
  required VoidCallback callbackRightButton,
  required AnimationController timerController,
  Color cardColor = Colors.white,
  Color titleColor = Colors.teal,
}) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            color: cardColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(30.0)),
            ),
            child: InkWell(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(30.0)),
                onTap: callbackLeftButton,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      titleLeftButton,
                      style: TextStyle(
                          fontSize: 17,
                          color: titleColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
          ),
        ),
      ),
      const Expanded(flex: 2, child: SizedBox()),
      Expanded(
        flex: 5,
        child: Container(),
      ),
      const Expanded(flex: 2, child: SizedBox()),
      Expanded(
        flex: 5,
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            color: cardColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(10.0)),
            ),
            child: InkWell(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(10.0)),
                onTap: callbackRightButton,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      titleRightButton,
                      style: TextStyle(
                          fontSize: 17,
                          color: titleColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
          ),
        ),
      ),
    ],
  );
}

Widget triviaBottomBar(
    {required int startPage,
    required int endPage,
    required int currentPage,
    required List<bool> answeredQuestions,
    required Function(int) callback,
    bool isPortrait = true,
    Color backgroundColor = Colors.white,
    Color answeredColor = Colors.teal,
    Color unansweredColor = Colors.black}) {
  return Align(
    alignment: AlignmentDirectional.bottomCenter,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.symmetric(horizontal: isPortrait ? 50 : 200),
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.grey, width: 0.7),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          for (int i = startPage; i < endPage; i++)
            Expanded(
              child: SlideNumbers(
                index: i,
                isActive: i == currentPage ? true : false,
                isAnswered: answeredQuestions[i],
                callback: () {
                  callback(i);
                },
                answeredColor: answeredColor,
                unansweredColor: unansweredColor,
              ),
            )
        ],
      ),
    ),
  );
}
