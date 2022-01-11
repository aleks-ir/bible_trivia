import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/models/database/verse.dart';
import 'package:weekly_bible_trivia/redux/actions/local_storage_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/search_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/database_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/highlight_text.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields.dart';

class SearchContainer extends StatefulWidget {
  const SearchContainer({Key? key}) : super(key: key);

  @override
  _SearchContainerState createState() {
    return _SearchContainerState();
  }
}

class _SearchContainerState extends State<SearchContainer>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late _ViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        onInit: (Store<AppState> store) {
          _searchController.text = store.state.searchState.keyword;
        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          _viewModel = viewModel;
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 10,
                        color: Color(index == 0
                            ? viewModel.primaryColor
                            : viewModel.iconColor),
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: viewModel.searchResult.length + 1,
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: isPortrait ? 20 : 50,
                                    right: isPortrait ? 20 : 50,
                                    bottom: isPortrait ? 20 : 20,
                                    top: isPortrait ? 20 : 20),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 20,
                                          child: searchTextField(
                                              callback: () {
                                                _searchController.text.isNotEmpty
                                                    ? viewModel.searchByKeyword(
                                                        _searchController.text)
                                                    : null;
                                              },
                                              controller: _searchController,
                                              textColor: Color(viewModel.textColor),
                                              borderColor:
                                                  Color(viewModel.iconColor)),
                                        ),
                                        Expanded(
                                            flex: isPortrait ? 4 : 3,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 5),
                                              height: 45,
                                              width: 45,
                                              child: FloatingActionButton(
                                                  backgroundColor:
                                                      Color(viewModel.primaryColor),
                                                  child: Icon(
                                                    viewModel.isSearching
                                                        ? Icons.sync
                                                        : Icons.search,
                                                    color:
                                                        Color(viewModel.iconColor),
                                                  ),
                                                  onPressed: () {
                                                    _searchController
                                                            .text.isNotEmpty
                                                        ? viewModel.searchByKeyword(
                                                            _searchController.text)
                                                        : null;
                                                  }),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                color: Color(viewModel.primaryColor),
                                child: ListTile(
                                  onTap: () {
                                    viewModel.navigateBackToReader(
                                        _getBookName(index - 1),
                                        _getChapter(index - 1),
                                        _getVerse(index - 1));
                                  },
                                  minVerticalPadding: 10,
                                  title: Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        _getTitleItem(index - 1),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(viewModel.textColor),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  subtitle: HighlightText(
                                    text: _getSubtitleItem(index - 1),
                                    highlightColor: Color(viewModel.iconColor),
                                    highlight: _searchController.text,
                                    textColor: Color(viewModel.textColor),
                                  ),
                                ),
                              );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  String _getBookName(int index) {
    return _viewModel.searchResult[index].bookName;
  }

  int _getChapter(int index) {
    return _viewModel.searchResult[index].chapter;
  }

  int _getVerse(int index) {
    return _viewModel.searchResult[index].verse;
  }

  String _getTitleItem(int index) {
    String bookName = _viewModel.searchResult[index].bookName;
    return _viewModel.language == RUSSIAN
        ? mapBooksRu[bookName] ?? ''
        : _viewModel.searchResult[index].bookName +
            "  " +
            _viewModel.searchResult[index].chapter.toString() +
            " : " +
            _viewModel.searchResult[index].verse.toString();
  }

  String _getSubtitleItem(int index) {
    return _viewModel.searchResult[index].text;
  }
}

class _ViewModel {
  final int primaryColor;
  final int secondColor;
  final int iconColor;
  final int textColor;
  final bool isSearching;
  final String language;
  final List<Verse> searchResult;

  final Function(String) searchByKeyword;
  final Function(String, int, int) navigateBackToReader;

  _ViewModel({
    required this.primaryColor,
    required this.secondColor,
    required this.iconColor,
    required this.textColor,
    required this.searchResult,
    required this.isSearching,
    required this.language,
    required this.searchByKeyword,
    required this.navigateBackToReader,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        primaryColor: store.state.themeSettingsState.primaryColor,
        secondColor: store.state.themeSettingsState.secondaryColor,
        iconColor: store.state.themeSettingsState.iconColor,
        textColor: store.state.themeSettingsState.textColor,
        searchResult: store.state.searchState.searchResult,
        language: store.state.localStorageState.language,
        isSearching: store.state.loadingState.isSearching,
        searchByKeyword: (value) => {
              store.dispatch(updateSearchResultThunk(value)),
            },
        navigateBackToReader: (bookName, chapter, verse) => {
              store.dispatch(UpdateReaderBookNameAction(bookName)),
              store.dispatch(UpdateReaderChapterAction(chapter)),
              store.dispatch(UpdateSearchVerseAction(verse)),
              store.dispatch(
                  updateScreenThunk(NavigateFromSearchToHomeScreenAction())),
            });
  }
}
