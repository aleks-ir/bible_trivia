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
  return Stack(
    children: [
      Positioned(
        left: 10,
        child: Container(
          width: 100,
          alignment: Alignment.topCenter,
          child: Card(
            color: cardColor,
            margin: const EdgeInsets.all(0),
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
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
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
      const Spacer(),
      Container(
        width: 100,
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
    ],
  );
}

class TriviaBottomBar extends StatelessWidget {
  final int startPage;
  final int endPage;
  final int currentPage;
  final List<bool> answeredQuestions;
  final Function(int) callback;
  final Color? backgroundColor;
  final Color? answeredColor;
  final Color? unansweredColor;

  const TriviaBottomBar({
    required this.startPage,
    required this.endPage,
    required this.currentPage,
    required this.answeredQuestions,
    required this.callback,
    this.backgroundColor,
    this.answeredColor,
    this.unansweredColor,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.grey, width: 0.3),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            for (int index = startPage; index < endPage; index++)
              Expanded(
                child: SlideNumbers(
                  index: index,
                  isActive: index == currentPage ? true : false,
                  isAnswered: answeredQuestions[index],
                  callback: () {
                    callback(index);
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
