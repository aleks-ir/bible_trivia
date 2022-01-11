import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'grids_view.dart';

ListView selectionReaderListView(
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
    physics: const ScrollPhysics(),
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

