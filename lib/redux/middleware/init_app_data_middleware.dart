import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/redux/actions/info_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/weekly_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'authentication_middleware.dart';
import 'database_middleware.dart';
import 'firebase_middleware.dart';
import 'local_storage_middleware.dart';


ThunkAction<AppState> createInitAppDataThunk() {
  return (Store<AppState> store) async {
    //var currentDate = await NTP.now();
    DateTime currentDate = DateTime.parse("2022-05-22");
    var weeklyTriviaDate = getNextTriviaDate(currentDate);

    String currentDateString = DateFormat('yyyy-MM-dd').format(currentDate);
    String weeklyTriviaDateString = DateFormat('yyyy-MM-dd').format(weeklyTriviaDate);

    store.dispatch(initDateThunk(currentDate, weeklyTriviaDate, weeklyTriviaDateString));
    store.dispatch(initAuthThunk(weeklyTriviaDateString));
    store.dispatch(initDatabaseThunk());
    store.dispatch(initSettingsThunk());
    store.dispatch(initImagesUrlFromFirebaseThunk());
    store.dispatch(initWeeklyTriviaThunk(weeklyTriviaDateString));
    store.dispatch(initPastTriviaThunk(currentDateString));
  };
}


DateTime getNextTriviaDate(DateTime currentDate) {
  var weekDay = currentDate.weekday;
  var nextTriviaDate = currentDate.subtract(Duration(days: weekDay));

  if(!compareToDate(currentDate, nextTriviaDate)){
    nextTriviaDate = currentDate.subtract(Duration(days: weekDay - 7));
  }
  return nextTriviaDate;
}



bool compareToDate(DateTime d1, DateTime d2) {
  return d1.year == d2.year && d1.month == d2.month
      && d1.day == d2.day;
}


ThunkAction<AppState> initDateThunk(DateTime currentDate, DateTime weeklyTriviaDate, String weeklyTriviaDateString) {
  return (Store<AppState> store) async {
    store.dispatch(UpdateCurrentDateAction(currentDate));
    store.dispatch(UpdateInfoTriviaDateAction(weeklyTriviaDate));
    store.dispatch(UpdateWeeklyTriviaDateAction(weeklyTriviaDateString));
  };
}