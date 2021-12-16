import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/database_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/widgets/selection_view.dart';

class TranslationContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              child: translationListView(
                  listTranslationsName: listTranslationsName,
                  listTranslationsId: listTranslationsId,
                  callback: (translation) {viewModel.setTranslation(translation);},
                  indexSelectedTranslation: selectIndexTranslation(viewModel.translationId),
                  primaryColor: Color(viewModel.primaryColor),
                  noActiveTextColor: Color(viewModel.noActiveTextColor),
                  activeTextColor: Color(viewModel.activeTextColor),
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final int primaryColor;
  final int noActiveTextColor;
  final int activeTextColor;
  final String translationId;

  final Function(String) setTranslation;

  _ViewModel({
    required this.primaryColor,
    required this.noActiveTextColor,
    required this.activeTextColor,
    required this.translationId,
    required this.setTranslation
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      primaryColor: store.state.themeSettingsState.primaryColor,
      noActiveTextColor: store.state.themeSettingsState.shadowColor,
      activeTextColor: store.state.themeSettingsState.textColor,
      translationId: store.state.localStorageState.translationId,
      setTranslation: (translation){
        store.dispatch(updateScreenThunk(
            saveTranslationIdThunk(translation)));
        store.dispatch(updateDatabaseThunk(selectTranslationUrl(translation)));
        store.dispatch(updateScreenThunk(
            NavigateFromTranslationToSelectionScreenAction()));
      },
    );
  }
}
