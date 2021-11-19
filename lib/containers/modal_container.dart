import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/constants/strings.dart';
import 'package:weekly_bible_trivia/constants/text_styles.dart';
import 'package:weekly_bible_trivia/models/authentication_status.dart';
import 'package:weekly_bible_trivia/models/user_firebase.dart';
import 'package:weekly_bible_trivia/redux/actions/transition_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/authentication_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
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
                height: viewModel.isAuthenticated ? 250 : isPortrait ? 180 : 150,
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
                      visible: viewModel.isAuthenticated ? true : false,
                      child: SizedBox(
                        height: isPortrait ? 20 : 10,
                      ),
                    ),
                    Visibility(
                      visible: viewModel.isAuthenticated ? true : false,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: ClipOval(child: FadeInImage.assetNetwork(placeholder: 'assets/images/loading.gif', image: viewModel.user.photoURL != '' ? viewModel.user.photoURL : defaultPhotoURL,)),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(viewModel.user.displayName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Edit profile",
                                  //"Edit profile",
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
                      height: isPortrait ? 10 : 0,
                    ),
                    SizedBox(
                      width: double.infinity, // <-- match_parent
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Table result",
                          style: TextStyles.buttonMoreTextStyle,),
                      ),
                    ),
                    SizedBox(
                      height: isPortrait ? 5 : 0,
                    ),
                    SizedBox(
                      width: double.infinity, // <-- match_parent
                      child: TextButton(
                        onPressed: () {},
                        child: Text("About",
                          style: TextStyles.buttonMoreTextStyle,),
                      ),
                    ),
                    SizedBox(
                      height: isPortrait ? 5 : 0,
                    ),
                    SizedBox(
                      width: double.infinity, // <-- match_parent
                      child: TextButton(
                        onPressed: viewModel.isAuthenticated
                            ? viewModel.navigateToSignOut
                            : viewModel.navigateToSignIn,
                        child: Text(
                            viewModel.isAuthenticated ? "Log out" : "Log in",
                          style: TextStyles.buttonMoreTextStyle,),
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
  final Function() navigateToSignIn;
  final Function() navigateToSignOut;
  final bool isAuthenticated;
  final UserFirebase user;

  _ViewModel({
    required this.navigateToSignIn,
    required this.navigateToSignOut,
    required this.isAuthenticated,
    required this.user,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      navigateToSignIn: () => store.dispatch(updateScreenThunk(NavigateToSignInAction())),
      navigateToSignOut: () => store.dispatch(createLogOutThunk()),
      isAuthenticated: store.state.authenticationState.status == AuthenticationStatus.loaded,
      user: store.state.authenticationState.user,
    );
  }
}
