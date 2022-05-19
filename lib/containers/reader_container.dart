import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/models/database/verse.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/database_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';
import 'package:weekly_bible_trivia/widgets/text_rich.dart';

class ReaderContainer extends StatefulWidget {
  const ReaderContainer({Key? key}) : super(key: key);

  @override
  _ReaderContainerState createState() {
    return _ReaderContainerState();
  }
}

class _ReaderContainerState extends State<ReaderContainer>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _buttonsAnimationController;
  late _ViewModel _viewModel;
  late Animation<Offset> _buttonNextOffset;
  late Animation<Offset> _buttonPrevOffset;

  @override
  void initState() {
    super.initState();
    _buttonsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scrollController = ScrollController();
    _scrollController.addListener(listen);

    _buttonNextOffset =
        Tween<Offset>(begin: Offset.zero, end: const Offset(2, 0))
            .animate(_buttonsAnimationController);
    _buttonPrevOffset =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-2, 0))
            .animate(_buttonsAnimationController);
  }

  void listen() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      _viewModel.changeReaderMod(false);
      _buttonsAnimationController.reverse();
    } else if (direction == ScrollDirection.reverse) {
      _viewModel.changeReaderMod(true);
      _buttonsAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _buttonsAnimationController.dispose();
    _scrollController.removeListener(listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          _viewModel = viewModel;
          return SizedBox.expand(
            child: Container(
                color: Color(viewModel.primaryColor),
                child: viewModel.isLoadingData
                    ? Center(
                        child: defaultCircularProgressIndicator(
                            Color(viewModel.iconColor)))
                    : Stack(children: [
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: ScrollConfiguration(
                            behavior: CustomScrollBehavior(),
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: viewModel.listVerses.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onHorizontalDragEnd: (drag) {
                                    if (drag.primaryVelocity == null) return;
                                    if (drag.primaryVelocity! < 0) {
                                      viewModel.changePage(
                                        _getNextChapter(),
                                      );
                                    } else {
                                      viewModel.changePage(
                                        _getPrevChapter(),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: index == 0 ? 90 : 5,
                                        bottom: index ==
                                                viewModel.listVerses.length - 1
                                            ? 90
                                            : 0,
                                        right: 15,
                                        left: 15),
                                    color: Color(viewModel.primaryColor),
                                    child: Center(
                                      child: TextReader(
                                        index: index,
                                        text: viewModel.listVerses[index].text,
                                        isSearchVerse:
                                            viewModel.searchVerse - 1 == index,
                                        fontSize: viewModel.fontSize,
                                        textColor: Color(viewModel.textColor),
                                        textSearchColor:
                                            Color(viewModel.iconColor),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          right: 10,
                          child: SlideTransition(
                            position: _buttonNextOffset,
                            child: readerFloatingActionButton(
                                Icon(Icons.navigate_next,
                                    size: 25,
                                    color: Color(viewModel.iconColor)), () {
                              viewModel.changePage(_getNextChapter());
                            }, color: Color(viewModel.primaryColor)),
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          left: 10,
                          child: SlideTransition(
                            position: _buttonPrevOffset,
                            child: readerFloatingActionButton(
                                Transform.rotate(
                                  angle: pi,
                                  child: Icon(Icons.navigate_next,
                                      size: 25,
                                      color: Color(viewModel.iconColor)),
                                ), () {
                              viewModel.changePage(
                                _getPrevChapter(),
                              );
                            }, color: Color(viewModel.primaryColor)),
                          ),
                        ),
                      ])),
          );
        });
  }

  int _getNextChapter() {
    int? maxChapter = mapCountChapters[_viewModel.bookName];
    if (maxChapter != null && _viewModel.chapter < maxChapter) {
      return _viewModel.chapter + 1;
    } else {
      return _viewModel.chapter;
    }
  }

  int _getPrevChapter() {
    if (_viewModel.chapter > 1) {
      return _viewModel.chapter - 1;
    } else {
      return _viewModel.chapter;
    }
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
      };
}

class _ViewModel {
  final int iconColor;
  final int primaryColor;
  final int textColor;
  final double fontSize;
  final String bookName;
  final int chapter;
  final int searchVerse;
  final List<Verse> listVerses;
  final bool isReaderMod;
  final bool isLoadingData;

  final Function(bool) changeReaderMod;
  final Function(int) changePage;

  _ViewModel({
    required this.iconColor,
    required this.primaryColor,
    required this.textColor,
    required this.fontSize,
    required this.bookName,
    required this.chapter,
    required this.searchVerse,
    required this.listVerses,
    required this.isReaderMod,
    required this.isLoadingData,
    required this.changeReaderMod,
    required this.changePage,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      iconColor: store.state.themeSettingsState.iconColor,
      primaryColor: store.state.themeSettingsState.primaryColor,
      textColor: store.state.themeSettingsState.textColor,
      bookName: store.state.localStorageState.bookName,
      chapter: store.state.localStorageState.chapter,
      searchVerse: store.state.searchState.verse,
      listVerses: store.state.readerState.textReader,
      fontSize: store.state.localStorageState.fontSize,
      isReaderMod: store.state.appBarState.isReaderMod,
      isLoadingData: store.state.loadingState.isLoadingDataFromApi,
      changeReaderMod: (value) {
        store.dispatch(UpdateReaderModAction(value));
        store.dispatch(UpdateShowMenuBarAction(false));
      },
      changePage: (chapter) {
        store.dispatch(saveChapterThunk(chapter));
        store.dispatch(updateTextReaderThunk());
      },
    );
  }
}
