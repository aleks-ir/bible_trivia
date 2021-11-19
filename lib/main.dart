import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/redux/actions/home_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/authentication_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/reducers/app_state_reduser.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/router.dart';
import 'package:weekly_bible_trivia/screens/home_screen.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';

import 'constants/route_paths.dart';
import 'utils/locator.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  late Store<AppState> _store = _store = Store<AppState>(appReducer,
      middleware: [thunkMiddleware, LoggingMiddleware.printer()],
      initialState: AppState.initial());

  final _applicationRouter = ApplicationRouter();


  @override
  Widget build(BuildContext context) {
    initAuth();
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


  void initAuth() {
    _store.dispatch(createInitAuthThunk());
  }
}
