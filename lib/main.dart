import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/reducers/app_state_reduser.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/router.dart';
import 'package:weekly_bible_trivia/screens/home_screen.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';

import 'constants/route_paths.dart';
import 'utils/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUpLocator();

  runApp(Note());
}

class Note extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  late Store<AppState> _store;

  final _applicationRouter = ApplicationRouter();

  @override
  void initState() {
    super.initState();
    _store = Store<AppState>(appReducer,
        middleware: [thunkMiddleware],
        initialState: AppState.initial());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: _store,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutePaths.HomeScreen,
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: _applicationRouter,
          ),
    );
  }
}
