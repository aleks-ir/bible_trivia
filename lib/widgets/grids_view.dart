import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/models/firebase/image_book.dart';

class PastTriviaSelectBookGridView extends StatelessWidget {
  final List<String> bookList;
  final List<String> displayBookList;
  final Map<String, String> bookImageUrlMap;
  final Function(String) callback;
  final Color primaryColor;
  final Color secondaryColor;
  final Color shadowColor;
  final Color textColor;

  const PastTriviaSelectBookGridView(
      {required this.bookList,
      required this.displayBookList,
      required this.callback,
      required this.bookImageUrlMap,
      this.primaryColor = Colors.white,
      this.secondaryColor = Colors.white,
      this.shadowColor = Colors.black12,
      this.textColor = Colors.black,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GridView.builder(
      itemCount: bookList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isPortrait ? 2 : 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        childAspectRatio: (2 / 1),
      ),
      padding: EdgeInsets.only(top: 130, left: 10, right: 10, bottom: isPortrait ? 100 : 60),
      itemBuilder: (
        context,
        index,
      ) {
        return GestureDetector(
          onTap: () {
            callback(bookList[index]);
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child:
                  CachedNetworkImage(
                    imageUrl: bookImageUrlMap[bookList[index]] ?? '',
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) => Center(
                        child: Image.asset(DEFAULT_PLACEHOLDER_IMG,
                            height: 50, width: 50)),
                  ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                decoration: BoxDecoration(
                  color: shadowColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  displayBookList[index],
                  style: TextStyle(color: primaryColor, fontSize: 11),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PastTriviaSelectChapterGridView extends StatelessWidget {
  final Function(int) changeChapterCallback;
  final String bookName;
  final int selectedChapter;
  final int? countChapters;
  final Axis scrollDirection;
  final Color? sellColor;
  final Color? selectedCellColor;
  final Color? textSelectedSellColor;
  final Color? textColor;

  const PastTriviaSelectChapterGridView(
      {required this.changeChapterCallback,
      required this.bookName,
      required this.selectedChapter,
      this.countChapters,
      this.scrollDirection = Axis.horizontal,
      this.sellColor,
      this.selectedCellColor,
      this.textSelectedSellColor,
      this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: scrollDirection,
        shrinkWrap: false,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50,
            childAspectRatio: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: countChapters,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () {
              changeChapterCallback(index + 1);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                    fontSize: 12,
                    color: selectedChapter - 1 == index
                        ? textSelectedSellColor
                        : textColor),
              ),
              decoration: BoxDecoration(
                  color: selectedChapter - 1 == index ? selectedCellColor : sellColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        });
  }
}


GridView selectionReaderGridView(
    {required String bookName,
      required int? countChapters,
      required Function(String, int) callback,
      Axis scrollDirection = Axis.horizontal,
      Color secondaryColor = Colors.black12,
      Color textColor = Colors.white}) {
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
