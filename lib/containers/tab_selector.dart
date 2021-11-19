import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/models/authentication_status.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_tab.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/containers/modal_container.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          iconSize: 20,
          unselectedFontSize: 10,
          selectedFontSize: 12,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black45,
          selectedItemColor: Colors.amber,
          currentIndex: AppTab.values.indexOf(vm.activeTab),
          onTap: (index) {
            switch (index) {
              case 3:
                //ModalWithoutAuthWidget(context).showModal();
                ModalBottomSheetContainer(context).showModal();
                break;
              default:
                vm.onTabSelected(index);
            }
          },
          items: AppTab.values.map((tab) {
            return BottomNavigationBarItem(
              icon: _getIcon(tab),
              label: _getLabel(tab),
            );
          }).toList(),
        );
      },
    );
  }

  Icon _getIcon(AppTab tab) {
    if (tab == AppTab.home) {
      return Icon(Icons.home);
    } else if (tab == AppTab.reader) {
      return Icon(Icons.book);
    } else if (tab == AppTab.pastTrivia) {
      return Icon(Icons.library_books_sharp);
    } else if (tab == AppTab.more) {
      return Icon(Icons.list);
    }
    return Icon(Icons.error);
  }

  String _getLabel(AppTab tab) {
    if (tab == AppTab.home) {
      return "Home";
    } else if (tab == AppTab.reader) {
      return "Bible";
    } else if (tab == AppTab.pastTrivia) {
      return "Trivia";
    } else if (tab == AppTab.more) {
      return "More";
    } else {
      return "Error";
    }
  }

  //TODO: move to widgets
}

class _ViewModel {
  final AppTab activeTab;
  final Function onTabSelected;
  final bool isAuthorized;

  _ViewModel({
    required this.activeTab,
    required this.onTabSelected,
    required this.isAuthorized,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      activeTab: store.state.activeTab,
      onTabSelected: (index) {
        store.dispatch(updateTabThunk(AppTab.values[index]));
      },
      isAuthorized: store.state.authenticationState.status == AuthenticationStatus.loaded,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          activeTab == other.activeTab;

  @override
  int get hashCode => activeTab.hashCode;
}

