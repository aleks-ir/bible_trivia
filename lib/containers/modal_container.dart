import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/redux/actions/autorization_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class ModalBottomSheetContainer {
  BuildContext context;

  ModalBottomSheetContainer(this.context);

  showModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StoreConnector<AppState, _ViewModel>(
            converter: (Store<AppState> store) =>
                _ViewModel.fromStore(store),
            builder: (context, _ViewModel viewModel) {
              bool isPortrait =
                  MediaQuery.of(context).orientation == Orientation.portrait;
              return Container(
                height: viewModel.isAuthorized ? 280 : 200,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: viewModel.isAuthorized ? true : false,
                      child: SizedBox(
                        height: isPortrait ? 30 : 10,
                      ),
                    ),
                    Visibility(
                      visible: viewModel.isAuthorized ? true : false,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://i.pinimg.com/736x/2c/15/22/2c15222f332f689b4cf89dd886af7d1d.jpg"),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("User name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Edit profile",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: isPortrait ? 20 : 0,
                    ),
                    SizedBox(
                      width: double.infinity, // <-- match_parent
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Table result",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                    ),
                    SizedBox(
                      height: isPortrait ? 10 : 0,
                    ),
                    SizedBox(
                      width: double.infinity, // <-- match_parent
                      child: TextButton(
                        onPressed: () {},
                        child: Text("About",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                    ),
                    SizedBox(
                      height: isPortrait ? 10 : 0,
                    ),
                    SizedBox(
                      width: double.infinity, // <-- match_parent
                      child: TextButton(
                        onPressed: viewModel.isAuthorized
                            ? viewModel.goToLogOutFunc
                            : viewModel.goToAuthorizationFunc,
                        child: Text(
                            viewModel.isAuthorized ? "Log out" : "Log in",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}

class _ViewModel {
  final Function() goToAuthorizationFunc;
  final Function() goToLogOutFunc;
  final bool isAuthorized;

  _ViewModel({
    required this.goToAuthorizationFunc,
    required this.goToLogOutFunc,
    required this.isAuthorized,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      goToAuthorizationFunc: () {
        store.dispatch(UpdateAuthorizationAction(true));
      },
      goToLogOutFunc: () {
        store.dispatch(UpdateAuthorizationAction(false));
      },
      isAuthorized: store.state.authorizationState.isAuthorized,
    );
  }
}
