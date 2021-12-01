import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/containers/modal_container.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, viewModel) {
        return BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(viewModel.tabBarColor),
          iconSize: 20,
          unselectedFontSize: 10,
          selectedFontSize: 12,
          showUnselectedLabels: true,
          unselectedItemColor: Color(viewModel.unselectedItemColor),
          selectedItemColor: Colors.teal,
          //const Color(0xfff063057),
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
              icon: _getIcon(tab),
              label: _getLabel(tab),
            );
          }).toList(),
        );
      },
    );
  }

  Icon _getIcon(NavigationTab tab) {
    if (tab == NavigationTab.home) {
      return Icon(Icons.home);
    } else if (tab == NavigationTab.reader) {
      return Icon(Icons.book);
    } else if (tab == NavigationTab.pastTrivia) {
      return Icon(Icons.library_books_sharp);
    } else if (tab == NavigationTab.more) {
      return Icon(Icons.list);
    }
    return Icon(Icons.error);
  }

  String _getLabel(NavigationTab tab) {
    if (tab == NavigationTab.home) {
      return "Home";
    } else if (tab == NavigationTab.reader) {
      return "Bible";
    } else if (tab == NavigationTab.pastTrivia) {
      return "Trivia";
    } else if (tab == NavigationTab.more) {
      return "More";
    } else {
      return "Error";
    }
  }

  //TODO: move to widgets
}

class _ViewModel {
  final int unselectedItemColor;
  final int tabBarColor;
  final NavigationTab activeTab;
  final Function onTabSelected;
  final Function hideMenuBar;
  

  _ViewModel({
    required this.unselectedItemColor,
    required this.tabBarColor,
    required this.activeTab,
    required this.onTabSelected,
    required this.hideMenuBar,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      unselectedItemColor: store.state.themeSettingsState.shadowColor,
      tabBarColor: store.state.themeSettingsState.appBarColor,
      activeTab: store.state.bottomBarState.activeTab,
      onTabSelected: (index) {
        store.dispatch(updateTabThunk(NavigationTab.values[index]));
        Future.delayed(const Duration(milliseconds: 500), () {store.dispatch(UpdateMenuBarAction(MenuBar.values[index]));});
      },
      hideMenuBar: () => store.dispatch(UpdateShowMenuBarAction(false)),
    );
  }
}

