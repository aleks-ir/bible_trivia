import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/weekly_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'navigation_middleware.dart';

ThunkAction<AppState> getAccessWeeklyTriviaThunk() {
  return (Store<AppState> store) {
    if (store.state.authenticationState.status != AuthenticationStatus.loaded) {
      store.dispatch(UpdateAccessWeeklyTriviaAction(false));
      store.dispatch(AccessWeeklyTriviaErrorAction(notAuthError.i18n));
    } else if (store.state.weeklyTriviaState.isPassed) {
      store.dispatch(UpdateAccessWeeklyTriviaAction(false));
      store.dispatch(AccessWeeklyTriviaErrorAction(answeredError.i18n));
    } else if (!compareToDate(store.state.infoTriviaState.currentDate,
        store.state.infoTriviaState.nextDate)) {
      store.dispatch(UpdateAccessWeeklyTriviaAction(false));
      store.dispatch(AccessWeeklyTriviaErrorAction(otherDateError.i18n));
    } else if(store.state.weeklyTriviaState.questions.isEmpty){
      store.dispatch(UpdateAccessWeeklyTriviaAction(false));
      store.dispatch(AccessWeeklyTriviaErrorAction(notQuestionsError.i18n));
    }
    else{
      store.dispatch(UpdateAccessWeeklyTriviaAction(true));
      store.dispatch(AccessWeeklyTriviaErrorAction(''));

      store.dispatch(UpdateIsTimeTriviaAction(true));
      store.dispatch(UpdateTriviaQuestionsAction(
          store.state.weeklyTriviaState.questions));
      store.dispatch(
          updateScreenThunk(NavigateFromHomeToTriviaScreenAction()));

    }
  };
}


bool compareToDate(DateTime d1, DateTime d2) {
  return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
}
