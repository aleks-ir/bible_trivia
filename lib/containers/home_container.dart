import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/firebase_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/firestore_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          return Container(
              margin: const EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                    //NetworkImage(getDownloadURL("Exodus")),
                    AssetImage(
                        selectBackgroundImage(viewModel.theme, isPortrait)),
                    fit: BoxFit.fill),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 30,
                    top: isPortrait ? 30 : 20,
                    child: Text(
                      _getDateString(viewModel.currentDate,
                          mapMonths: selectMapMonths(viewModel.language)),
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: INTER,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          fontSize: 18),
                    ),
                  ),
                ],
              ));
        });
  }

  String _getDateString(DateTime currentDate,
      {Map<int, String> mapMonths = const {}}) {
    if (mapMonths.isEmpty) {
      return currentDate.day.toString() +
          " - " +
          currentDate.month.toString() +
          " - " +
          currentDate.year.toString();
    } else {
      String month = mapMonths[currentDate.month] ?? "";
      return currentDate.day.toString() +
          " " +
          month +
          " " +
          currentDate.year.toString();
    }
  }

  bool _compareToDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}

class _ViewModel {
  final bool isLoadingData;
  final int primaryColor;
  final int shadowColor;
  final int iconColor;
  final int textColor;
  final String theme;
  final String language;
  final DateTime currentDate;

  _ViewModel({
    required this.isLoadingData,
    required this.primaryColor,
    required this.shadowColor,
    required this.iconColor,
    required this.textColor,
    required this.theme,
    required this.language,
    required this.currentDate,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      isLoadingData: store.state.loadingState.isLoadingDataFromFirebase,
      primaryColor: store.state.themeSettingsState.primaryColor,
      shadowColor: store.state.themeSettingsState.shadowColor,
      iconColor: store.state.themeSettingsState.iconColor,
      textColor: store.state.themeSettingsState.textColor,
      theme: store.state.localStorageState.theme,
      language: store.state.localStorageState.language,
      currentDate: store.state.infoTriviaState.currentDate,
    );
  }
}
