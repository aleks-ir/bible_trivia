import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/containers/modal_container.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/utils/sliding_bottombar.dart';

class TabSelector extends StatefulWidget {
  final AnimationController controller;

  TabSelector(this.controller) : super();

  @override
  _TabSelectorState createState() {
    return _TabSelectorState(controller);
  }
}

class _TabSelectorState extends State<TabSelector> {
  final AnimationController controller;

  _TabSelectorState(this.controller) : super();

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late int _currentIndexTabBar;

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
          controller: controller,
          visible: !viewModel.isReaderMod,
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: _currentIndexTabBar,
            height: 60.0,
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
              switch (index) {
                case 3:
                  setState(() {
                    _currentIndexTabBar = index;
                  });
                  Future.delayed(const Duration(milliseconds: 600), () async {
                    ModalBottomSheetContainer(context).showModal(() {
                      _bottomNavigationKey.currentState!.setPage(
                          NavigationTab.values.indexOf(viewModel.activeTab));
                    });
                  });
                  break;
                default:
                  setState(() {
                    _currentIndexTabBar = index;
                  });
                  viewModel.hideMenuBar();
                  viewModel.onTabSelected(index);
              }
            },
            letIndexChange: (index) => true,
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final int bottomBarColor;
  final int secondaryColor;
  final int iconColor;
  final String theme;
  final int tabBarColor;
  final NavigationTab activeTab;
  final bool isReaderMod;
  final Function onTabSelected;
  final Function hideMenuBar;

  _ViewModel({
    required this.bottomBarColor,
    required this.secondaryColor,
    required this.iconColor,
    required this.theme,
    required this.tabBarColor,
    required this.activeTab,
    required this.isReaderMod,
    required this.onTabSelected,
    required this.hideMenuBar,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      bottomBarColor: store.state.themeSettingsState.appBarColor,
      secondaryColor: store.state.themeSettingsState.secondaryColor,
      iconColor: store.state.themeSettingsState.iconColor,
      theme: store.state.localStorageState.theme,
      tabBarColor: store.state.themeSettingsState.appBarColor,
      activeTab: store.state.bottomBarState.activeTab,
      isReaderMod: store.state.appBarState.isReaderMod,
      onTabSelected: (index) {
        store.dispatch(updateTabThunk(NavigationTab.values[index]));
        Future.delayed(const Duration(milliseconds: 500), () {
          store.dispatch(UpdateMenuBarAction(MenuBar.values[index]));
        });
      },
      hideMenuBar: () => store.dispatch(UpdateShowMenuBarAction(false)),
    );
  }
}
