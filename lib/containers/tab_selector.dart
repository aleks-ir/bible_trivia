import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/containers/modal_container.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/widgets/sliding_bottombar.dart';

class TabSelector extends StatelessWidget {
  final AnimationController controller;
  const TabSelector(this.controller, {Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, viewModel) {
        return SlidingBottomNavigationBar(
          controller: controller,
          visible: !viewModel.isReaderMod,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(viewModel.tabBarColor),
            iconSize: 20,
            unselectedFontSize: 10,
            selectedFontSize: 12,
            showUnselectedLabels: true,
            unselectedItemColor: viewModel.theme == DARK ? Colors.white : Colors.black54,
            selectedItemColor: Color(viewModel.iconColor),
            currentIndex: NavigationTab.values.indexOf(viewModel.activeTab),
            onTap: (index) {
              switch (index) {
                case 3:
                  ModalBottomSheetContainer(context).showModal();
                  break;
                default:
                  viewModel.hideMenuBar();
                  viewModel.onTabSelected(index);
              }
            },
            items: NavigationTab.values.map((tab) {
              return BottomNavigationBarItem(
                icon: selectIconBottomBar(tab),
                label: selectLabelBottomBar(tab),
              );
            }).toList(),
          ),
        );
      },
    );
  }

}

class _ViewModel {
  final int iconColor;
  final String theme;
  final int tabBarColor;
  final NavigationTab activeTab;
  final bool isReaderMod;
  final Function onTabSelected;
  final Function hideMenuBar;
  

  _ViewModel({
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
      iconColor: store.state.themeSettingsState.iconColor,
      theme: store.state.localStorageState.theme,
      tabBarColor: store.state.themeSettingsState.appBarColor,
      activeTab: store.state.bottomBarState.activeTab,
      isReaderMod: store.state.appBarState.isReaderMod,
      onTabSelected: (index) {
        store.dispatch(updateTabThunk(NavigationTab.values[index]));
        Future.delayed(const Duration(milliseconds: 500), () {
          store.dispatch(UpdateMenuBarAction(MenuBar.values[index]));});
      },
      hideMenuBar: () => store.dispatch(UpdateShowMenuBarAction(false)),
    );
  }
}

