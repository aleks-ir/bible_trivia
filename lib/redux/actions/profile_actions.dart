
import 'package:weekly_bible_trivia/models/user_firebase.dart';

class EditProfileSuccessfulAction {
  final UserFirebase user;
  EditProfileSuccessfulAction(this.user);
}

class UpdateLoadingAction {
  final bool loading;
  UpdateLoadingAction(this.loading);
}
