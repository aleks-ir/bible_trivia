import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/containers/modal_container.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/navigation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/selectors.dart';
import 'package:weekly_bible_trivia/utils/sliding_bottombar.dart';

class TabSelector extends StatefulWidget {
  final AnimationController _navigationController;

  const TabSelector(this._navigationController, {Key? key}) : super(key: key);

  
  @override
  _TabSelectorState createState() {
    return _TabSelectorState(_navigationController);
  }
}

class _TabSelectorState extends State<TabSelector>
    with TickerProviderStateMixin {
  final AnimationController _navigationController;
  late AnimationController _modalAnimationController;
  late Animation<double> _imageScaleAnimations;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late int _currentIndexTabBar;

  _TabSelectorState(this._navigationController) : super();

  @override
  void initState() {
    super.initState();
    _modalAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    
    _imageScaleAnimations = CurvedAnimation(
        parent: _modalAnimationController, curve: Curves.easeIn);
  }

  @override
  void dispose(){
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
          controller: _navigationController,
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

              setState(() {
                _currentIndexTabBar = index;
              });

              switch (index) {
                case 3:
                  setState(() {
                    _currentIndexTabBar = index;
                  });
                  Future.delayed(const Duration(milliseconds: 600), () async {
                    _modalAnimationController.forward();
                    ModalBottomSheetContainer(context, _imageScaleAnimations)
                        .showModal(() {
                      _bottomNavigationKey.currentState!.setPage(
                          NavigationTab.values.indexOf(viewModel.activeTab));
                      _modalAnimationController.reverse();
                    });
                  });
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
}

class _ViewModel {
  final int bottomBarColor;
  final int secondaryColor;
  final int iconColor;
  final String theme;
  final int tabBarColor;
  final NavigationTab activeTab;
  final bool isReaderMod;
  final Function(int) onTabSelected;
  final Function(int) hideMenuBar;
  final Function() hidePastTriviaDialog;

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
    required this.hidePastTriviaDialog,
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
      },
      hideMenuBar: (index) {
        Future.delayed(const Duration(milliseconds: 500), () {
          store.dispatch(UpdateMenuBarAction(MenuBar.values[index]));
        });
        store.dispatch(UpdateShowMenuBarAction(false));
      },
      hidePastTriviaDialog: () => store.dispatch(ResetPastTriviaAction()),
    );
  }
}
