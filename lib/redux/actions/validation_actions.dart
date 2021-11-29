
import 'package:weekly_bible_trivia/models/enums.dart';

class NameErrorAction{
  final String message;
  final Screens screen;
  NameErrorAction(this.message, this.screen);
}

class EmailErrorAction{
  final String message;
  final Screens screen;
  EmailErrorAction(this.message, this.screen);
}

class PasswordErrorAction{
  final String message;
  final Screens screen;
  PasswordErrorAction(this.message, this.screen);
}

class RetypePasswordErrorAction{
  final String message;
  final Screens screen;
  RetypePasswordErrorAction(this.message, this.screen);
}


class ChangeValidationStatusAction{
  final ValidationStatus status;
  ChangeValidationStatusAction(this.status);
}

class ClearErrorsAction{}

