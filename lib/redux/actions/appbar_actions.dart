import 'package:weekly_bible_trivia/constants/enums/menu_bars.dart';


class UpdateShowMenuBarAction {
  final bool isShowMenuBar ;
  UpdateShowMenuBarAction(this.isShowMenuBar);
}

class UpdateMenuBarAction {
  final MenuBar newMenuBar;
  UpdateMenuBarAction(this.newMenuBar);
}

