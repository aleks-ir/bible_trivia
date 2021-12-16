import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_bible_trivia/dao/book_dao.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/redux/actions/database_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/loading_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/utils/api_provider.dart';
import 'package:weekly_bible_trivia/utils/database_helper.dart';

import 'local_storage_middleware.dart';

ThunkAction<AppState> createInitDatabaseThunk() {
  return (Store<AppState> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DatabaseHelper databaseHelper = DatabaseHelper();
    BookDao bookDao = await databaseHelper.bookDao;

    ApiProvider apiProvider = ApiProvider(bookDao);

    bool hasData = prefs.getBool(DB_HAS_DATA) ?? false;
    if (!hasData) {
      store.dispatch(UpdateLoadingAppDataFromApiAction(true));
      var verses = await apiProvider.loadFromApi(ASV_URL);
      await bookDao.runInsertVerses(verses).then((value) {
        store.dispatch(saveDBHasDataThunk(true));
        store.dispatch(updateChapterThunk());
        store.dispatch(UpdateLoadingAppDataFromApiAction(false));
      });
    }


  };
}

ThunkAction<AppState> updateChapterThunk() {
  return (Store<AppState> store) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    BookDao bookDao = await databaseHelper.bookDao;
    store.dispatch(UpdateTextReaderAction(await bookDao.getChapter(
        store.state.localStorageState.bookName,
        store.state.localStorageState.chapter)));
  };
}

ThunkAction<AppState> updateDatabaseThunk(String translationUrl) {
  return (Store<AppState> store) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    BookDao bookDao = await databaseHelper.bookDao;
    ApiProvider apiProvider = ApiProvider(bookDao);

    await bookDao.deleteAllVerses();

    store.dispatch(UpdateLoadingAppDataFromApiAction(true));
    var verses = await apiProvider.loadFromApi(translationUrl);
    await bookDao.runInsertVerses(verses).then((value) {
      store.dispatch(saveDBHasDataThunk(true));
      store.dispatch(updateChapterThunk());
      store.dispatch(UpdateLoadingAppDataFromApiAction(false));
    });
  };
}

ThunkAction<AppState> updateTextReaderThunk() {
  return (Store<AppState> store) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    BookDao bookDao = await databaseHelper.bookDao;
    //store.dispatch(UpdateTextReaderAction(await bookDao.readChapter(1)));
  };
}
