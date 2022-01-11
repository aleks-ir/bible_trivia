import 'package:weekly_bible_trivia/global/enums.dart';

class UpdateReaderModAction {
  final bool isReaderMod ;
  UpdateReaderModAction(this.isReaderMod);
}

class UpdateShowMenuBarAction {
  final bool isShowMenuBar ;
  UpdateShowMenuBarAction(this.isShowMenuBar);
}

class UpdateTestamentAction {
  final bool isOldTestament ;
  UpdateTestamentAction(this.isOldTestament);
}

class UpdateMenuBarAction {
  final MenuBar newMenuBar;
  UpdateMenuBarAction(this.newMenuBar);
}

