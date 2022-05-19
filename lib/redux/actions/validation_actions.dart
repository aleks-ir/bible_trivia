
import 'package:weekly_bible_trivia/global/enums.dart';

class NameErrorAction{
  final String message;
  final Screen screen;
  NameErrorAction(this.message, this.screen);
}

class EmailErrorAction{
  final String message;
  final Screen screen;
  EmailErrorAction(this.message, this.screen);
}

class PasswordErrorAction{
  final String message;
  final Screen screen;
  PasswordErrorAction(this.message, this.screen);
}

class RetypePasswordErrorAction{
  final String message;
  final Screen screen;
  RetypePasswordErrorAction(this.message, this.screen);
}


class ChangeValidationStatusAction{
  final ValidationStatus status;
  ChangeValidationStatusAction(this.status);
}

class ClearSignInErrorsAction{}

class ClearSignUpErrorsAction{}

