import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
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
          _viewModel = viewModel;
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              child: ListView.separated(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 10,
                  color: Colors.grey,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: viewModel.searchResult.length + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 10, top: 30),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SearchTextField(
                                          onSubmitted:
                                              viewModel.searchByKeyword,
                                          controller: _searchController,
                                          textColor: Color(viewModel.textColor),
                                          borderColor:
                                              Color(viewModel.iconColor),
                                          focusedBorderColor:
                                              Color(viewModel.iconColor),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      GestureDetector(
                                        onTap: () => viewModel.searchByKeyword(
                                            _searchController.text),
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(
                                                      viewModel.iconColor)),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Icon(
                                            viewModel.isSearching
                                                ? Icons.sync
                                                : Icons.search,
                                            size: 18,
                                            color: Color(viewModel.iconColor),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: viewModel.searchResult.isEmpty
                                        ? null
                                        : Text(
                                            "${results.i18n}: ${viewModel.searchResult.length}",
                                            style: TextStyle(
                                                color:
                                                    Color(viewModel.textColor)),
                                          ),
                                  )
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
                                  viewModel.searchResult[index - 1].bookName,
                                  viewModel.searchResult[index - 1].chapter,
                                  viewModel.searchResult[index - 1].verse);
                            },
                            minVerticalPadding: 10,
                            title: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  _getTitleItem(index - 1, viewModel.language,
                                      viewModel.searchResult),
                                  style: TextStyle(
                                      fontSize: 15,
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
            ),
          );
        });
  }

  String _getTitleItem(int index, String language, List<Verse> searchResult) {
    final bookName = language == RUSSIAN
        ? mapBooksRu[searchResult[index].bookName]
        : searchResult[index].bookName;
    return "$bookName ${searchResult[index].chapter} : ${searchResult[index].verse}";
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
              if (value.isNotEmpty && !store.state.loadingState.isSearching)
                {
                  store.dispatch(updateSearchResultThunk(value)),
                }
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
