import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/redux/middleware/authentication_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/local_storage_middleware.dart';
import 'package:weekly_bible_trivia/redux/reducers/app_state_reduser.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';
import 'package:weekly_bible_trivia/utils/router.dart';

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
  late Store<AppState> _store = _store = Store<AppState>(appReducer,
      middleware: [thunkMiddleware, LoggingMiddleware.printer()],
      initialState: AppState.initial());

  final _applicationRouter = ApplicationRouter();

  @override
  Widget build(BuildContext context) {
    initAppData(_store, context);
    return StoreProvider<AppState>(
      store: _store,
      child: I18n(
        child:
        // _store.state.isLoading
        //     ? MaterialApp(
        //         home: Scaffold(
        //           backgroundColor: Colors.white,
        //           body: Center(
        //             child: Image.asset('assets/images/logo.png'),
        //            // CircularProgressIndicator(),
        //           ),
        //         ),
        //       )
        //     :
        MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: RoutePaths.toHomeScreen,
                navigatorKey: locator<NavigationService>().navigatorKey,
                onGenerateRoute: _applicationRouter,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en'),
                  const Locale('ru'),
                ],
              ),
      ),
    );
  }

  void initAppData(Store<AppState> store, BuildContext context)async {
    store.dispatch(createInitAuthThunk());
    store.dispatch(createInitSettingsThunk(context));
  }
}
