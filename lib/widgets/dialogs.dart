import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';

import 'grids_view.dart';

Widget pastTriviaDialog({double padding: 20,
  required String bookName,
  required int selectedChapter,
  required String? displayBookName,
  required int? countChapters,
  required Function(int) callback,
  required Function() closeCallback,
  required Function() confirmCallback,
  bool isPortrait: true,
  Color backgroundColor: Colors.white,
  Color sellColor: Colors.black12,
  Color selectedCellColor: Colors.black26,
  Color textColor: Colors.black}) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(padding),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: Container(
      height: isPortrait ? 380 : 240,
      padding: EdgeInsets.only(left: padding, top: padding, right: padding),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(padding),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 2), blurRadius: 10),
          ]),
      child: Column(
        children: [
          Text(
            displayBookName ?? "",
            style: TextStyle(fontSize: 16, color: textColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: isPortrait ? 20 : 10,
          ),
          Text(
            chooseChapter.i18n,
            style: TextStyle(fontSize: 16, color: textColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: isPortrait ? 20 : 10,
          ),
          SizedBox(
            height: isPortrait ? 200.0 : 100,
            child: pastTriviaSelectChapterGridView(
                bookName: bookName,
                selectedChapter: selectedChapter,
                countChapters: countChapters,
                callback: callback,
                scrollDirection: Axis.vertical,
                sellColor: sellColor,
                selectedCellColor: selectedCellColor,
                textSelectedSellColor: backgroundColor,
                textColor: textColor),
          ),
          SizedBox(
            height: isPortrait ? 20 : 10,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: selectedChapter != -1 ? confirmCallback : null,
                    child: Text(
                      confirm.i18n,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: selectedChapter != -1 ? textColor : selectedCellColor),
                    )),
                TextButton(
                    onPressed: closeCallback,
                    child: Text(close.i18n,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    )),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
