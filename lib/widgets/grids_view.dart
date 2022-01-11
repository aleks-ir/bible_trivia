import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GridView pastTriviaSelectBookGridView(
    {required List<String> listImages,
    required List<String> listBooks,
    required List<String> listDisplayBooks,
    required Function(String) callback,
    bool isPortrait = true,
    Color primaryColor = Colors.white,
    Color shadowColor = Colors.black12,
    Color textColor = Colors.black}) {
  return GridView.builder(
    itemCount: listBooks.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: isPortrait ? 1 : 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      childAspectRatio: (2 / 1),
    ),
    itemBuilder: (
      context,
      index,
    ) {
      return GestureDetector(
        onTap: () {
          callback(listBooks[index]);
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                Image.asset(listImages[index]),
                Container(
                    height: 30,
                    width: 500,
                    color: shadowColor,
                    child: Center(
                        child: Text(
                      listDisplayBooks[index],
                      style: TextStyle(color: primaryColor),
                    ))),
              ],
            )),
      );
    },
  );
}

GridView pastTriviaSelectChapterGridView(
    {required String bookName,
    required int selectedChapter,
    required int? countChapters,
    required Function(int) callback,
    Axis scrollDirection: Axis.horizontal,
    Color sellColor: Colors.black12,
    Color selectedCellColor: Colors.black26,
    Color textSelectedSellColor: Colors.black,
    Color textColor: Colors.white}) {
  int selectedCell = selectedChapter - 1;
  return GridView.builder(
      scrollDirection: scrollDirection,
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
            selectedCell = index;
            callback(index + 1);
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                  color: selectedCell == index
                      ? textSelectedSellColor
                      : textColor),
            ),
            decoration: BoxDecoration(
                color: selectedCell == index ? selectedCellColor : sellColor,
                borderRadius: BorderRadius.circular(10)),
          ),
        );
      });
}

GridView selectionReaderGridView(
    {required String bookName,
    required int? countChapters,
    required Function(String, int) callback,
    Axis scrollDirection: Axis.horizontal,
    Color secondaryColor: Colors.black12,
    Color textColor: Colors.white}) {
  return GridView.builder(
      scrollDirection: scrollDirection,
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
            callback(bookName, index + 1);
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              (index + 1).toString(),
              style: TextStyle(color: textColor),
            ),
            decoration: BoxDecoration(
                color: secondaryColor, borderRadius: BorderRadius.circular(10)),
          ),
        );
      });
}
