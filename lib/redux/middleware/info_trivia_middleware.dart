import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/redux/actions/info_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/weekly_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'firebase_middleware.dart';




ThunkAction<AppState> initInfoTriviaThunk() {
  return (Store<AppState> store) async {
    var formatter = DateFormat('yyyy-MM-dd');
    var currentDate = await NTP.now();
    var weekDay = currentDate.weekday;
    var nextTriviaDate = currentDate.subtract(Duration(days: weekDay));

    store.dispatch(UpdateCurrentDateAction(currentDate));

    if(compareToDate(currentDate, nextTriviaDate)){
      store.dispatch(UpdateWeeklyTriviaDateAction(formatter.format(nextTriviaDate)));
      store.dispatch(UpdateInfoTriviaDateAction(nextTriviaDate));
    }else{
      nextTriviaDate = currentDate.subtract(Duration(days: weekDay - 7));
      store.dispatch(UpdateInfoTriviaDateAction(nextTriviaDate));
    }

    store.dispatch(initBookAndChaptersThunk(formatter.format(nextTriviaDate)));
    store.dispatch(initListsOfBooksAndCountChaptersThunk(formatter.format(currentDate)));
  };
}

bool compareToDate(DateTime d1, DateTime d2) {
  return d1.year == d2.year && d1.month == d2.month
      && d1.day == d2.day;
}