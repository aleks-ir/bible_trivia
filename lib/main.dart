import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_bible_trivia/redux/actions/local_storage_actions.dart';
import 'package:weekly_bible_trivia/redux/middleware/authentication_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/reducers/app_state_reduser.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';
import 'package:weekly_bible_trivia/utils/router.dart';

import 'constants/route_paths.dart';
import 'constants/strings.dart';
import 'utils/locator.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WeeklyTriviaBibleApp());
}


class WeeklyTriviaBibleApp extends StatelessWidget {

  late Store<AppState> _store = _store = Store<AppState>(appReducer,
      middleware: [thunkMiddleware, LoggingMiddleware.printer()],
      initialState: AppState.initial());

  final _applicationRouter = ApplicationRouter();

  void getFontSize() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double fontSize = prefs.getDouble(FONT_SIZE) ?? 20;
    _store.dispatch(UpdateFontSizeAction(fontSize));
  }

  @override
  Widget build(BuildContext context) {
          //createInitAuthThunk();
          //createInitSettingsThunk();
          //saveFontSizeThunk(30);
          //getFontSize();

          _store.dispatch(createInitAuthThunk());
          _store.dispatch(createInitSettingsThunk());
          return StoreProvider<AppState>(
            store: _store,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RoutePaths.toMainScreen,
              navigatorKey: locator<NavigationService>().navigatorKey,
              onGenerateRoute: _applicationRouter,
            ),
          );


  }
}
