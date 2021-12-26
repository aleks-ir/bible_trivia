import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_list.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/database_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/widgets/lists_view.dart';

class SelectionReaderContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              child: Container(
                child: selectionListView(
                    callback: (String bookName, int chapter) {
                      viewModel.setBookAndChapter(bookName, chapter);
                    },
                    listDisplayBooks: selectListDisplayBooks(viewModel.isOldTestament, viewModel.language == ENGLISH),
                  mapCountChapters: mapCountChapters,
                    listBooks: viewModel.isOldTestament ? listBooksOldTestamentEn : listBooksNewTestamentEn,
                    isPortrait: isPortrait,
                    primaryColor: Color(viewModel.primaryColor),
                  secondaryColor: Color(viewModel.secondaryColor),
                  textColor: Color(viewModel.textColor),
                ),
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final int primaryColor;
  final int secondaryColor;
  final int shadowColor;
  final int textColor;
  final bool isOldTestament;
  final String language;

  final Function(String, int) setBookAndChapter;

  _ViewModel({
    required this.primaryColor,
    required this.secondaryColor,
    required this.shadowColor,
    required this.textColor,
    required this.language,
    required this.isOldTestament,
    required this.setBookAndChapter,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      primaryColor: store.state.themeSettingsState.primaryColor,
      secondaryColor: store.state.themeSettingsState.secondaryColor,
      shadowColor: store.state.themeSettingsState.shadowColor,
      textColor: store.state.themeSettingsState.textColor,
      isOldTestament: store.state.appBarState.isOldTestament,
      language: store.state.localStorageState.language,
      setBookAndChapter: (String bookName, int chapter) {
        store.dispatch(saveBookNameThunk(bookName));
        store.dispatch(saveChapterThunk(chapter));
        store.dispatch(updateTextReaderThunk());
        store.dispatch(updateScreenThunk(
            NavigateFromSelectionToHomeScreenAction()));
      },
    );
  }
}
