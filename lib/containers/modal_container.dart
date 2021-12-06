import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/text_styles.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/user_firebase.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
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
            converter: (Store<AppState> store) => _ViewModel.fromStore(store),
            builder: (context, _ViewModel viewModel) {
              bool isPortrait =
                  MediaQuery.of(context).orientation == Orientation.portrait;
              Color colorButton = viewModel.themeType == ThemeType.dark ? Colors.white70 : Colors.brown;
              return Container(
                height: viewModel.isAuthenticated
                    ? 160
                    : 110,
                decoration: BoxDecoration(
                  color: Color(viewModel.primaryColor),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: viewModel.isAuthenticated ? true : false,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(viewModel.primaryColor)),
                              primary: Colors.teal),
                          onPressed: viewModel.navigateToEditProfile,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CircleAvatar(
                              //width: 40,
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/loading.gif',
                                  image:  viewModel.user.photoURL.isNotEmpty ? viewModel.user.photoURL : DEFAULT_PHOTO_URL,
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/default_user.jpg',
                                        fit: BoxFit.fitWidth);
                                  },
                                )
                              ),
                            ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(viewModel.user.displayName,
                                      style: TextStyle(color: Color(viewModel.textColor),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(editProfile.i18n,
                                      style: TextStyle(
                                          color: colorButton,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: viewModel.isAuthenticated ? 10 : 0,
                      ),
                      Visibility(
                        visible: viewModel.isAuthenticated,
                        child: Expanded(
                            child:  Divider()
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: isPortrait ? 6 : 11,
                            child: TextButton(
                              onPressed: viewModel.navigateToTableResults,
                              child: Text(
                                results.i18n,
                                style: TextStyles.getButtonMoreTextStyle(colorButton),
                              ),
                            ),
                          ),
                          Expanded(flex: 3, child: IconButton(icon: Image.asset('assets/images/logo.png'), iconSize: 70, onPressed: viewModel.navigateToAbout,)),
                          Expanded(flex: isPortrait ? 6 : 11,
                            child: TextButton(
                              onPressed: viewModel.isAuthenticated
                                  ? viewModel.navigateToSignOut
                                  : viewModel.navigateToSignIn,
                              child: Text(
                                viewModel.isAuthenticated ? signOut.i18n : authorization.i18n,
                                style: TextStyles.getButtonMoreTextStyle(colorButton),
                              ),
                            ),
                          ),
                          //Expanded(child: SizedBox()),
                        ],
                      ),
                    ],
                    ),

              );
            });
      },
    );
  }
}

class _ViewModel {
  final int primaryColor;
  final int textColor;
  final ThemeType themeType;
  final bool isAuthenticated;
  final UserFirebase user;

  final Function() navigateToSignIn;
  final Function() navigateToSignOut;
  final Function() navigateToTableResults;
  final Function() navigateToAbout;
  final Function() navigateToEditProfile;

  _ViewModel({
    required this.primaryColor,
    required this.textColor,
    required this.themeType,
    required this.isAuthenticated,
    required this.user,
    required this.navigateToSignIn,
    required this.navigateToSignOut,
    required this.navigateToTableResults,
    required this.navigateToAbout,
    required this.navigateToEditProfile,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      primaryColor: store.state.themeSettingsState.primaryColor,
      textColor: store.state.themeSettingsState.textColor,
      themeType: store.state.localStorageState.theme,
      isAuthenticated:
      store.state.authenticationState.status == AuthenticationStatus.loaded,
      user: store.state.authenticationState.user,
      navigateToSignIn: () => store
          .dispatch(updateScreenThunk(NavigateFromHomeToSignInScreenAction())),
      navigateToSignOut: () => store.dispatch(createLogOutThunk()),
      navigateToTableResults: () => store
          .dispatch(updateScreenThunk(NavigateFromHomeToTableResultsScreenAction())),
      navigateToAbout: () => store
          .dispatch(updateScreenThunk(NavigateFromHomeToAboutScreenAction())),
      navigateToEditProfile: () => store
          .dispatch(updateScreenThunk(NavigateFromHomeToEditProfileScreenAction())),
    );
  }
}
