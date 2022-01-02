import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/constants_map.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';

class HomeContainer extends StatefulWidget {
  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer>
    with TickerProviderStateMixin {
  late double _scale;
  late AnimationController _animationControllerButton;

  @override
  void initState() {
    _animationControllerButton = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationControllerButton.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          _scale = 0.8 - _animationControllerButton.value;
          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;

          return Container(
              margin: EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        selectBackgroundImage(viewModel.theme, isPortrait)),
                    fit: BoxFit.fill),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: isPortrait ? 30 : 60, top: isPortrait ? 40 : 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _getDateString(viewModel.currentDate,
                            mapMonths: selectMapMonths(viewModel.language)),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: INTER,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: isPortrait
                            ? MediaQuery.of(context).size.height / 4
                            : 80),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            (viewModel.language == RUSSIAN
                                    ? mapBooksRu[viewModel.nextTriviaBook] ?? ''
                                    : viewModel.nextTriviaBook) +
                                "\t\t" +
                                viewModel.nextTriviaChapters,
                            style: TextStyle(
                                fontFamily: OPEN_SANS,
                                fontWeight: FontWeight.w600,
                                fontSize: 26,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: isPortrait ? 10 : 5,
                          ),
                          Text(
                            viewModel.nextTriviaBook.isEmpty
                                ? ''
                                : _getDateString(viewModel.nextTriviaDate),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: INTER,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: isPortrait ? 20 : 10,
                          ),
                          Visibility(
                            visible: !viewModel.isPassed &&
                                _compareToDate(viewModel.currentDate,
                                    viewModel.nextTriviaDate),
                            child: GestureDetector(
                              onHorizontalDragStart: _drag,
                              onVerticalDragStart: _drag,
                              onTapDown: _tapDown,
                              onTapUp: _tapUp,
                              child: Transform.scale(
                                  scale: _scale,
                                  child: animatedHomeButton(
                                    title: go.i18n,
                                    height: 140,
                                    width: 50,
                                    textColor: Colors.teal,
                                    //Color(viewModel.primaryColor),
                                    backgroundColor:
                                        Color(viewModel.primaryColor),
                                    //Color(viewModel.textColor)
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  String _getDateString(DateTime currentDate,
      {Map<int, String> mapMonths: const {}}) {
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

  void _drag(DragStartDetails details) {
    _animationControllerButton.reverse();
  }

  void _tapDown(TapDownDetails details) {
    _animationControllerButton.fling();
  }

  void _tapUp(TapUpDetails details) {
    _animationControllerButton.reverse();
  }
}

class _ViewModel {
  final int primaryColor;
  final int secondaryColor;
  final int shadowColor;
  final int textColor;
  final String theme;
  final String language;
  final bool isPassed;
  final bool isAuthenticated;
  final String nextTriviaBook;
  final String nextTriviaChapters;
  final DateTime nextTriviaDate;
  final DateTime currentDate;

  final Function(bool) changeShowedInfoTrivia;

  _ViewModel({
    required this.primaryColor,
    required this.secondaryColor,
    required this.shadowColor,
    required this.textColor,
    required this.theme,
    required this.language,
    required this.isPassed,
    required this.isAuthenticated,
    required this.nextTriviaBook,
    required this.nextTriviaChapters,
    required this.nextTriviaDate,
    required this.currentDate,
    required this.changeShowedInfoTrivia,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      primaryColor: store.state.themeSettingsState.primaryColor,
      secondaryColor: store.state.themeSettingsState.secondaryColor,
      shadowColor: store.state.themeSettingsState.shadowColor,
      textColor: store.state.themeSettingsState.textColor,
      theme: store.state.localStorageState.theme,
      language: store.state.localStorageState.language,
      isPassed: store.state.weeklyTriviaState.isPassed,
      isAuthenticated:
          store.state.authenticationState.status == AuthenticationStatus.loaded,
      currentDate: store.state.infoTriviaState.currentDate,
      nextTriviaBook: store.state.infoTriviaState.nextBookName,
      nextTriviaDate: store.state.infoTriviaState.nextDate,
      nextTriviaChapters: store.state.infoTriviaState.nextChapters,

      changeShowedInfoTrivia: (bool value) {
        store.dispatch(ChangeShowInfoTriviaAction(value));
      },
    );
  }
}
