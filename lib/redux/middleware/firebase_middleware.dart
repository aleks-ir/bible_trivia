import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/models/firebase/image_book.dart';
import 'package:weekly_bible_trivia/models/firebase/question.dart';
import 'package:weekly_bible_trivia/models/firebase/record.dart';
import 'package:weekly_bible_trivia/models/firebase/trivia.dart';
import 'package:weekly_bible_trivia/redux/actions/info_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/loading_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/past_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/table_results_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/weekly_trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'navigation_middleware.dart';

ThunkAction<AppState> initIsPassedWeeklyTriviaThunk(
    String userId, String date) {
  return (Store<AppState> store) async {
    bool isPassed = false;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('records')
        .where('date', isEqualTo: date)
        .get();
    for (var record in snapshot.docs) {
      if ((record.data())['uid'] == userId) {
        isPassed = true;
      }
    }
    store.dispatch(UpdateWeeklyTriviaPassedAction(isPassed));
  };
}

ThunkAction<AppState> getRecordsFromFirebaseThunk() {
  return (Store<AppState> store) async {
    //String date = await getPrevTriviaDate();
    String date = "2022-01-09";
    List<Record> listRecords = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('records')
        .where('date', isEqualTo: date)
        .get();

    for (var doc in snapshot.docs) {
      var data = doc.data();
      Record record = Record.fromJson(data);
      listRecords.add(record);
    }
    listRecords.sort((a, b) => a.percentCorrect.compareTo(b.percentCorrect));
    store.dispatch(UpdateListRecordsAction(listRecords));
  };
}

Future<String> getPrevTriviaDate() async {
  var currentDate = await NTP.now();
  var weekDay = currentDate.weekday;
  var prevTriviaDate = currentDate.subtract(Duration(days: weekDay));
  return DateFormat('yyyy-MM-dd').format(prevTriviaDate);
}

ThunkAction<AppState> initWeeklyTriviaThunk(String date) {
  return (Store<AppState> store) async {
    int runtime = 0;
    List<Question> questions = [];
    String bookName = '';
    StringBuffer chapters = StringBuffer();
    
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('trivia')
        .where('date', isEqualTo: date)
        .get();
    
    for (var doc in snapshot.docs) {
      var data = doc.data();
      bookName = data['book'];
      chapters.write(data['chapter'].toString());
      chapters.write(' ');
    }
    store.dispatch(UpdateInfoTriviaBookAction(bookName));
    store.dispatch(UpdateInfoTriviaChaptersAction(chapters.toString()));

    
    for (var doc in snapshot.docs) {
      var data = doc.data();
      Trivia trivia = Trivia.fromJson(data);
      runtime += trivia.runtime;
      questions.addAll(trivia.questions);
    }
    questions.shuffle(Random());
    store.dispatch(UpdateRuntimeAction(runtime));
    store.dispatch(UpdateWeeklyTriviaQuestionsAction(questions));
    
  };
}

ThunkAction<AppState> initPastTriviaThunk(
    String date) {
  return (Store<AppState> store) async {
    String uniqueBookName = '';
    List<String> listBookNames = [];
    Map<String, int> mapCountPastChapters = {};

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('trivia')
        .where('date', isLessThan: date)
        .get();

    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        String bookName = data['book'];
        int countChapters = data['chapter'];
        if (uniqueBookName != bookName) {
          uniqueBookName = bookName;
          listBookNames.add(bookName);
        }
        mapCountPastChapters[bookName] = countChapters;
      }
    }
    store.dispatch(UpdateListPastBookNamesAction(listBookNames));
    store.dispatch(UpdateMapCountPastChaptersAction(mapCountPastChapters));
  };
}


ThunkAction<AppState> getDataPastTriviaFromFirebaseAndNavigateThunk() {
  return (Store<AppState> store) async {
    store.dispatch(UpdateLoadingAppDataFromFirebaseAction(true));
    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference categories = instance.collection('trivia');

    String docName = store.state.pastTriviaState.bookName +
        "_" +
        store.state.pastTriviaState.chapter.toString();
    DocumentSnapshot snapshot = await categories.doc(docName).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      Trivia trivia = Trivia.fromJson(data);
      Future.delayed(const Duration(milliseconds: 500), (){
        store.dispatch(UpdateTriviaQuestionsAction(trivia.questions));
        store.dispatch(updateScreenThunk(NavigateFromHomeToTriviaScreenAction()));
        store.dispatch(ResetTriviaDialogAction());
        store.dispatch(UpdateLoadingAppDataFromFirebaseAction(false));
      });
    }
  };
}

ThunkAction<AppState> createRecordToFirebaseThunk(int percentOfCorrectAnswers) {
  return (Store<AppState> store) async {
    CollectionReference records =
        FirebaseFirestore.instance.collection('records');

    Record record = Record(
        percentCorrect: percentOfCorrectAnswers,
        date: store.state.weeklyTriviaState.date,
        name: store.state.authenticationState.user.displayName,
        uid: store.state.authenticationState.user.uid);

    records
        .add(record.toJson())
        .catchError((error) => print("Failed to add record: $error"));
  };
}

ThunkAction<AppState> initImagesUrlFromFirebaseThunk() {
  return (Store<AppState> store) async {
    List<ImageBook> images = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('images').get();

    for (var doc in snapshot.docs) {
      var data = doc.data();
      images.add(ImageBook.fromJson(data));
    }
    final bookImageUrlMap = _buildBookImageUrlMap(
        store.state.pastTriviaState.listPastBookNames, images);
    store.dispatch(UpdateBookImageUrlMapAction(bookImageUrlMap));
  };
}

Map<String, String> _buildBookImageUrlMap(
    List<String> bookNames, List<ImageBook> images) {
  final Map<String, String> bookImageUrlMap = {};
  images.shuffle(Random());
  for(var bookName in bookNames){
    bookImageUrlMap[bookName] = images
        .firstWhere((element) => element.book == bookName).url;
  }
  return bookImageUrlMap;
}
