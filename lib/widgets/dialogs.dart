import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';

import 'buttons.dart';
import 'grids_view.dart';

class PastTriviaDialog extends StatelessWidget {
  final Function(int) changeChapterCallback;
  final Function() confirmCallback;
  final Function() closeCallback;
  final bool isLoadingData;
  final String bookName;
  final String displayBookName;
  final int selectedChapter;
  final int? countChapters;
  final double padding;
  final Color? backgroundColor;
  final Color? sellColor;
  final Color? selectedCellColor;
  final Color? textColor;

  const PastTriviaDialog(
      {required this.changeChapterCallback,
      required this.confirmCallback,
      required this.closeCallback,
      required this.isLoadingData,
      required this.bookName,
      required this.displayBookName,
      required this.selectedChapter,
      this.countChapters,
      this.padding = 15,
      this.backgroundColor,
      this.sellColor,
      this.selectedCellColor,
      this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isPortrait ? 40 : 80),
        child: Container(
          height: isPortrait ? 230 : 190,
          padding: EdgeInsets.only(left: padding, top: padding, right: padding),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, 1),
                    blurRadius: 10),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                '${book.i18n} $displayBookName',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                chooseChapter.i18n,
                style: TextStyle(fontSize: 13, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: isPortrait ? 80 : 40,
                child: isLoadingData
                    ? Center(
                        child: defaultCircularProgressIndicator(Colors.grey))
                    : PastTriviaSelectChapterGridView(
                        changeChapterCallback: changeChapterCallback,
                        bookName: bookName,
                        selectedChapter: selectedChapter,
                        countChapters: countChapters,
                        scrollDirection: Axis.horizontal,
                        sellColor: sellColor,
                        selectedCellColor: selectedCellColor,
                        textSelectedSellColor: backgroundColor,
                        textColor: textColor),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all(const StadiumBorder())),
                    onPressed: selectedChapter != -1 ? confirmCallback : null,
                    child: Text(
                      continueTo.i18n,
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: INTER,
                          color: selectedChapter != -1
                              ? textColor
                              : selectedCellColor),
                    )),
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WeeklyTriviaDialog extends StatelessWidget {
  final Function() confirmCallback;
  final Function() closeCallback;
  final bool isLoadingData;
  final String infoTriviaBook;
  final String infoTriviaDate;
  final String infoTriviaChapters;
  final String infoQuestionCount;
  final String infoRuntime;
  final double padding;
  final Color? backgroundColor;
  final Color? textColor;

  const WeeklyTriviaDialog(
      {required this.confirmCallback,
      required this.closeCallback,
      required this.isLoadingData,
      required this.infoTriviaBook,
      required this.infoTriviaDate,
      required this.infoTriviaChapters,
      required this.infoQuestionCount,
      required this.infoRuntime,
      this.padding = 15,
      this.backgroundColor,
      this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isPortrait ? 40 : 80),
        child: Container(
          height: 190,
          padding: EdgeInsets.only(left: padding, top: padding, right: padding),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, 1),
                    blurRadius: 10),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                about.i18n,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              )),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.menu_book,
                    color: textColor,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('$infoTriviaBook $infoTriviaChapters',
                      style: TextStyle(fontSize: 14, color: textColor)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.today,
                    color: textColor,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(infoTriviaDate,
                      style: TextStyle(fontSize: 14, color: textColor)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.question_answer,
                    color: textColor,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('$infoQuestionCount ${questions.i18n}',
                      style: TextStyle(fontSize: 14, color: textColor)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.schedule,
                    color: textColor,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      '${(int.parse(infoRuntime) / 60).truncate()} ${minutes.i18n}',
                      style: TextStyle(fontSize: 14, color: textColor)),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all(const StadiumBorder())),
                    onPressed: confirmCallback,
                    child: Text(
                      continueTo.i18n,
                      style: TextStyle(
                          fontSize: 13, fontFamily: INTER, color: textColor),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TriviaDialog extends StatelessWidget {
  final Function() closeCallback;
  final Function() confirmCallback;
  final double padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? textButtonColor;

  const TriviaDialog(
      {required this.confirmCallback,
      required this.closeCallback,
      this.padding = 10,
      this.backgroundColor,
      this.textColor,
      this.textButtonColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isPortrait ? 40 : 80),
      child: Container(
        height: 140,
        padding: EdgeInsets.only(left: padding, top: padding, right: padding),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54, offset: Offset(0, 1), blurRadius: 10),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              exit.i18n,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              completeTrivia.i18n,
              style: TextStyle(fontSize: 14, color: textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            const Divider(thickness: 2, height: 0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppTextButton(
                  callback: closeCallback,
                  radius: 30,
                  title: no.i18n,
                  textColor: textButtonColor,
                ),
                AppTextButton(
                  callback: confirmCallback,
                  radius: 30,
                  title: yes.i18n,
                  textColor: textButtonColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
