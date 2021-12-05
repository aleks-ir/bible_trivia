import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class TableResultsContainer extends StatelessWidget {
  final List<String> listNames = <String>['First', 'Second', 'Third'];
  final List<String> listResults = <String>['90', '75', '50'];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(viewModel.secondaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    top.i18n,
                                    style: TextStyle(
                                        color: Color(viewModel.primaryColor)),
                                  ),
                                )),
                                decoration: BoxDecoration(
                                  color: Color(viewModel.shadowColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ))),
                        Expanded(
                            flex: 4,
                            child: Center(
                                child: Text(
                              name.i18n,
                              style:
                                  TextStyle(color: Color(viewModel.textColor)),
                            ))),
                        Expanded(
                            flex: 2,
                            child: Container(
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    result.i18n,
                                    style: TextStyle(
                                        color: Color(viewModel.primaryColor)),
                                  ),
                                )),
                                decoration: BoxDecoration(
                                  color: Color(viewModel.shadowColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ))),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: listNames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                        child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          color: Color(viewModel.textColor)),
                                    ))),
                                Expanded(
                                    flex: 4,
                                    child: Center(
                                        child: Text(listNames[index],
                                            style: TextStyle(
                                                color: Color(
                                                    viewModel.textColor))))),
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                        child: Text(listResults[index] + " %",
                                            style: TextStyle(
                                                color: Color(
                                                    viewModel.textColor))))),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
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

  _ViewModel({
    required this.primaryColor,
    required this.secondaryColor,
    required this.shadowColor,
    required this.textColor,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      primaryColor: store.state.themeSettingsState.primaryColor,
      secondaryColor: store.state.themeSettingsState.secondaryColor,
      shadowColor: store.state.themeSettingsState.shadowColor,
      textColor: store.state.themeSettingsState.textColor,
    );
  }
}
