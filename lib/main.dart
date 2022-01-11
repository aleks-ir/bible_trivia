import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/redux/middleware/authentication_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/database_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/firebase_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/init_app_data_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/reducers/app_state_reduser.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';
import 'package:weekly_bible_trivia/utils/router.dart';

import 'global/constants.dart';
import 'global/route_paths.dart';
import 'utils/locator.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    WeeklyTriviaBibleApp(),
  );
}

class WeeklyTriviaBibleApp extends StatelessWidget {
  final Store<AppState> _store = Store<AppState>(appReducer,
      middleware: [thunkMiddleware, LoggingMiddleware.printer()],
      initialState: AppState.initial());

  final _applicationRouter = ApplicationRouter();

  WeeklyTriviaBibleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initAppData(context);
    return StoreProvider<AppState>(
      store: _store,
      child: I18n(
        child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: RoutePaths.toHomeScreen,
                navigatorKey: locator<NavigationService>().navigatorKey,
                onGenerateRoute: _applicationRouter,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ru'),
                ],
              ),
      ),
    );
  }

  void initAppData(BuildContext context) async {
    _store.dispatch(createInitAppDataThunk());
    precacheImages(context);
  }

  void precacheImages(BuildContext context) {
    precacheImage(const AssetImage(LOGO_IMG), context);
    precacheImage(const AssetImage(HOME_DV_IMG), context);
    precacheImage(const AssetImage(HOME_DH_IMG), context);
    precacheImage(const AssetImage(HOME_LV_IMG), context);
    precacheImage(const AssetImage(HOME_LH_IMG), context);
    precacheImage(const AssetImage(BIBLE_IMG), context);
    precacheImage(const AssetImage(PIGEON_IMG), context);
  }
}
