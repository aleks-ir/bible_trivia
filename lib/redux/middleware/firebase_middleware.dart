import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/models/firestore/question.dart';
import 'package:weekly_bible_trivia/models/firestore/trivia.dart';
import 'package:weekly_bible_trivia/redux/actions/info_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/trivia_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

ThunkAction<AppState> initBookAndChaptersThunk(String date) {
  return (Store<AppState> store) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('trivia')
        .where('date', isEqualTo: date)
        .get();

    List<QueryDocumentSnapshot> docs = snapshot.docs;
    var firstDoc = docs.first;
    var lastDoc = docs.last;
    if (firstDoc.data() != null && lastDoc != null) {
      var firstData = firstDoc.data() as Map<String, dynamic>;
      var lastData = lastDoc.data() as Map<String, dynamic>;

      store.dispatch(UpdateInfoTriviaBookAction(firstData['book']));
      store.dispatch(UpdateInfoTriviaChaptersAction(
          firstData['chapter'].toString() +
              " - " +
              lastData['chapter'].toString()));
    }
  };
}

ThunkAction<AppState> initListsOfBooksAndCountChaptersThunk(String date) {
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
        if(uniqueBookName != bookName){
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

ThunkAction<AppState> getTriviaCollectionFromFirebaseThunk() {
  return (Store<AppState> store) async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference categories = instance.collection('trivia');

    DocumentSnapshot snapshot = await categories.doc('Exodus_1').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      //var categoriesData = data['Exodus_1'];
      Trivia cat = Trivia.fromJson(data);
      List<Question> list = [];
      list.addAll(cat.questions);
      // list.addAll(cat.questions);
      // list.addAll(cat.questions);
      store.dispatch(UpdateListQuestionsAction(list));
    }
  };
}
