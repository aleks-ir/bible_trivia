import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/route_paths.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/utils/sliding_bottombar.dart';

class TabSelector extends StatefulWidget {
  final AnimationController navigationController;

  const TabSelector(this.navigationController, {Key? key}) : super(key: key);

  @override
  _TabSelectorState createState() {
    return _TabSelectorState();
  }
}

class _TabSelectorState extends State<TabSelector>
    with TickerProviderStateMixin {
  late AnimationController _modalAnimationController;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late int _currentIndexTabBar;

  _TabSelectorState() : super();

  @override
  void initState() {
    super.initState();
    _modalAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _modalAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (Store<AppState> viewModel) {
        _currentIndexTabBar = NavigationTab.values
            .indexOf(viewModel.state.bottomBarState.activeTab);
      },
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, viewModel) {
        return SlidingBottomNavigationBar(
          controller: widget.navigationController,
          visible: !viewModel.isReaderMod,
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: _currentIndexTabBar,
            height: 50.0,
            items: NavigationTab.values.map((tab) {
              return selectIconBottomBar(
                  tab,
                  tab.index == _currentIndexTabBar
                      ? Colors.white
                      : Color(viewModel.iconColor));
            }).toList(),
            color: Color(viewModel.bottomBarColor),
            buttonBackgroundColor: Color(viewModel.iconColor),
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _currentIndexTabBar = index;
              });
              switch (index) {
                case 3:
                  setState(() {
                    _currentIndexTabBar = index;
                  });
                  viewModel.resetAuthError();
                  if (!viewModel.isActiveAnimation) {
                    viewModel.updateIsActiveAnimation(true);
                    Future.delayed(const Duration(milliseconds: 550), () async {
                      viewModel.hideMenuBar(index);
                      _modalAnimationController.forward();
                      viewModel.updateIsActiveAnimation(false);
                      navigate(viewModel);
                    });
                  }
                  break;
                default:
                  viewModel.hideMenuBar(index);
                  viewModel.hidePastTriviaDialog();
                  viewModel.onTabSelected(index);
              }
            },
            letIndexChange: (index) => true,
          ),
        );
      },
    );
  }

  void navigate(_ViewModel viewModel) async {
    Navigator.of(context)
        .pushNamed(viewModel.isAuthenticated
            ? RoutePaths.fromHomeToProfileScreen
            : RoutePaths.fromHomeToSignInScreen)
        .whenComplete(() {
      _bottomNavigationKey.currentState!
          .setPage(NavigationTab.values.indexOf(viewModel.activeTab));
      _modalAnimationController.reverse();
    });
  }
}

class _ViewModel {
  final int bottomBarColor;
  final int secondaryColor;
  final int iconColor;
  final String theme;
  final int tabBarColor;
  final bool isAuthenticated;
  final bool isActiveAnimation;
  final NavigationTab activeTab;
  final bool isReaderMod;
  final Function(int) onTabSelected;
  final Function(int) hideMenuBar;
  final Function() hidePastTriviaDialog;
  final Function(bool) updateIsActiveAnimation;
  final Function() resetAuthError;

  _ViewModel({
    required this.bottomBarColor,
    required this.secondaryColor,
    required this.iconColor,
    required this.theme,
    required this.tabBarColor,
    required this.isAuthenticated,
    required this.isActiveAnimation,
    required this.activeTab,
    required this.isReaderMod,
    required this.updateIsActiveAnimation,
    required this.onTabSelected,
    required this.hideMenuBar,
    required this.hidePastTriviaDialog,
    required this.resetAuthError,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        bottomBarColor: store.state.themeSettingsState.appBarColor,
        secondaryColor: store.state.themeSettingsState.secondaryColor,
        iconColor: store.state.themeSettingsState.iconColor,
        theme: store.state.localStorageState.theme,
        tabBarColor: store.state.themeSettingsState.appBarColor,
        isAuthenticated: store.state.authenticationState.status ==
            AuthenticationStatus.loaded,
        activeTab: store.state.bottomBarState.activeTab,
        isActiveAnimation: store.state.bottomBarState.isActiveAnimation,
        isReaderMod: store.state.appBarState.isReaderMod,
        onTabSelected: (index) {
          store.dispatch(updateTabThunk(NavigationTab.values[index]));
        },
        hideMenuBar: (index) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if(index != 3){
              store.dispatch(UpdateMenuBarAction(MenuBar.values[index]));
            }
          });
          if (store.state.appBarState.isShowMenuBar) {
            store.dispatch(UpdateShowMenuBarAction(false));
          }
        },
        hidePastTriviaDialog: () => store.dispatch(ResetTriviaDialogAction()),
        updateIsActiveAnimation: (value) => store.dispatch(
              UpdateActiveAnimation(value),
            ),
        resetAuthError: () {
          store.dispatch(ClearSignUpErrorsAction());
          store.dispatch(ClearSignInErrorsAction());
        });
  }
}
