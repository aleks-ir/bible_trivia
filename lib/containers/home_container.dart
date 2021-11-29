import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/models/enums.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons/home_button.dart';
import 'package:weekly_bible_trivia/widgets/home_dialog.dart';
import 'package:weekly_bible_trivia/widgets/home_painter.dart';

class HomeContainer extends StatefulWidget {
  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer>
    with TickerProviderStateMixin {
  late double _scale;
  late AnimationController _animationControllerButton;
  late bool _isPortrait;
  late AnimationController _animationControllerText;
  late Animation<int> _characterCount;
  late _ViewModel _vm;
  late String _infoAboutCurrentTrivia;
  bool isShowDialog = false;

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

    _animationControllerText = new AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _vm.changeShowedInfoTrivia(true);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationControllerText.dispose();
    _animationControllerButton.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          initData(viewModel);

          final Card infoCard = Card(
            child: ListTile(
                minVerticalPadding: 30,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      "Info about current trivia",
                      style: TextStyles.homeInfoCardTitileStyle,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    viewModel.isShowedInfoTrivia
                        ? Text(_infoAboutCurrentTrivia,
                            style: TextStyles.homeInfoCardStyle)
                        : AnimatedBuilder(
                            animation: _characterCount,
                            builder: (BuildContext context, Widget? child) {
                              String text = _infoAboutCurrentTrivia.substring(
                                  0, _characterCount.value);
                              return Text(
                                text,
                                style: TextStyles.homeInfoCardStyle,
                              );
                            },
                          ),
                  ],
                )),
            elevation: 8,
            shadowColor: Colors.green,
            margin: EdgeInsets.only(left: 80, right:  _isPortrait ? 80 : 20),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white, width: 1)),
          );

          final Widget mainButton = GestureDetector(
            onHorizontalDragStart: _drag,
            onVerticalDragStart: _drag,
            onTapDown: _tapDown,
            onTapUp: _tapUp,
            child: Transform.scale(
                scale: _scale,
                child: animatedHomeButton(
                    title: viewModel.isShowedInfoTrivia ? "Go" : "Show",
                    height: _isPortrait ? 140 : 80,
                    width: _isPortrait ? 60 : 80)),
          );

          return CustomPaint(
            painter: _isPortrait ? HomePainter() : null,
            child: isShowDialog
                ? homeDialog(
                    onPressed: () {
                      isShowDialog = false;
                      setState(() {});
                    },
                    image: Image.asset("assets/images/info.png"))
                : SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: _isPortrait
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              infoCard,
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 100, top: 20,),
                                child: mainButton,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(flex: 2, child: SizedBox()),
                              Expanded(flex: 5, child: infoCard),
                              Expanded(flex: 1, child: mainButton),
                              Expanded(flex: 2, child: SizedBox()),
                            ],
                          ),
                  ),
          );
        });
  }

  void _drag(DragStartDetails details) {
    _animationControllerButton.reverse();
  }

  void _tapDown(TapDownDetails details) {
    _animationControllerButton.fling();
  }

  void _tapUp(TapUpDetails details) {
    if (_vm.isShowedInfoTrivia) {
      if (_vm.isAuthenticated) {
      } else {
        isShowDialog = true;
      }
    } else {
      _animationControllerText.forward();
    }
    _animationControllerButton.reverse();
  }

  void initData(_ViewModel viewModel) {
    _scale = 0.8 - _animationControllerButton.value;
    _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    _vm = viewModel;
    _infoAboutCurrentTrivia = _getInfoAboutCurrentTrivia();
    _characterCount =
        new StepTween(begin: 0, end: _infoAboutCurrentTrivia.length).animate(
            new CurvedAnimation(
                parent: _animationControllerText, curve: Curves.easeIn));
  }

  String _getInfoAboutCurrentTrivia() {
    String book = _vm.book;
    String chapters = _vm.chapters;
    String date = _vm.date;
    String countQuestion = _vm.countQuestion.toString();
    String time = (_vm.time / 60).toString();
    return "Book: $book\nChapters: $chapters\nDate: $date\nCount Question: $countQuestion\nTime: $time min";
  }
}


class _ViewModel {
  final bool isAuthenticated;
  final bool isShowedInfoTrivia;
  final String book;
  final String chapters;
  final String date;
  final int countQuestion;
  final int time;

  final Function(bool) changeShowedInfoTrivia;

  _ViewModel(
      {required this.isAuthenticated,
      required this.isShowedInfoTrivia,
      required this.book,
      required this.chapters,
      required this.date,
      required this.countQuestion,
      required this.time,
      required this.changeShowedInfoTrivia});

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        isAuthenticated: store.state.authenticationState.status ==
            AuthenticationStatus.loaded,
        countQuestion: store.state.infoTriviaState.countQuestion,
        isShowedInfoTrivia: store.state.homeState.isShowedInfoTrivia,
        time: store.state.infoTriviaState.time,
        book: store.state.infoTriviaState.book,
        date: store.state.infoTriviaState.date,
        chapters: store.state.infoTriviaState.chapters,
        changeShowedInfoTrivia: (bool value) {
          store.dispatch(ChangeShowInfoTriviaAction(value));
        });
  }
}
