
import 'package:dio/dio.dart';
import 'package:weekly_bible_trivia/dao/book_dao.dart';
import 'package:weekly_bible_trivia/models/database/verse.dart';

class ApiProvider {
  BookDao bookDao;

  ApiProvider(this.bookDao);

  Future<List<Verse>> loadFromApi(String url) async{
    Response response = await Dio().get(url);
    List<Verse> verses = [];
    for(dynamic verse in response.data){
      verses.add(Verse.fromJson(verse));
    }
    return verses;
  }

}
