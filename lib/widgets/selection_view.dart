import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ListView selectionListView(
    {required List<String> listBooks,
    required List<String> listDisplayBooks,
    required Map<String, int> mapCountChapters,
    required Function(String, String, int) callback,
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
                child: selectionGridView(
                    bookName: listBooks[index],
                    displayBookName: listDisplayBooks[index],
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

GridView selectionGridView(
    {required String bookName,
      required String displayBookName,
    required int? countChapters,
    required Function(String, String, int) callback,
    Color secondaryColor: Colors.black12,
    Color textColor: Colors.white}) {
  return GridView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50,
          childAspectRatio: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
      itemCount: countChapters,
      itemBuilder: (BuildContext ctx, index) {
        return GestureDetector(
          onTap: () {
            callback(bookName, displayBookName, index + 1);
          },
          child: Container(
            alignment: Alignment.center,
            child: Text((index + 1).toString(), style: TextStyle(color: textColor),),
            decoration: BoxDecoration(
                color: secondaryColor, borderRadius: BorderRadius.circular(10)),
          ),
        );
      });
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
              onTap: (){callback(listTranslationsId[index]);},
              child: Text(listTranslationsName[index],
                  style: TextStyle(color: indexSelectedTranslation != index ? noActiveTextColor : activeTextColor)),
            ),
          ),
        ),
      );
    },
  );
}
