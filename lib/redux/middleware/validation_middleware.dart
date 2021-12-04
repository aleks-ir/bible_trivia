
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/signin_request.dart';
import 'package:weekly_bible_trivia/models/signup_request.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'authentication_middleware.dart';




ThunkAction<AppState> validateSignInThunk(SignInRequest request) {
  return (Store<AppState> store) {
    Screen screen = Screen.SIGNIN;
    bool isValidEmail = validateEmail(request.email, screen, store);
    bool isValidPassword = validatePassword(request.password, screen, store);
    if (isValidEmail && isValidPassword) {
      store.dispatch(createSignInThunk(request));
    } else {
      store.dispatch(ChangeValidationStatusAction(ValidationStatus.error));
    }
  };
}

ThunkAction<AppState> validateSignUpThunk(SignUpRequest request) {
  return (Store<AppState> store) {
    Screen screen = Screen.SIGNUP;
    bool isValidName = validateName(request.name, screen, store);
    bool isValidEmail = validateEmail(request.email, screen, store);
    bool isValidPassword = validatePassword(request.password, screen, store);
    bool isValidPasswordMatch = validatePassMatch(
        request.password, request.retypePassword, screen, store);
    if (isValidName && isValidEmail && isValidPassword && isValidPasswordMatch) {
      store.dispatch(createSignUpThunk(request));
    } else {
      store.dispatch(ChangeValidationStatusAction(ValidationStatus.error));
    }
  };
}


ThunkAction<AppState> validatePassMatchThunk(String password, String confirmPassword, Screen screen,) {
  return (Store<AppState> store) {
    validatePassMatch(password, confirmPassword, screen, store);
  };
}

ThunkAction<AppState> validatePasswordThunk(String password, Screen screen) {
  return (Store<AppState> store) {
    validatePassword(password, screen, store);
  };
}

ThunkAction<AppState> validateEmailThunk(String email, Screen screen) {
  return (Store<AppState> store) {
    validateEmail(email, screen, store);
  };
}

ThunkAction<AppState> validateNameThunk(String name, Screen screen) {
  return (Store<AppState> store) {
    validateName(name, screen, store);
  };
}


bool validatePassMatch(String password, String confirmPassword,
    Screen screen, Store<AppState> store) {
  if (password != confirmPassword) {
    store.dispatch(RetypePasswordErrorAction(passwordMatchError.i18n, screen));
    return false;
  } else {
    store.dispatch(RetypePasswordErrorAction("", screen));
    return true;
  }
}

bool validatePassword(
    String password, Screen screen, Store<AppState> store) {
  if (password.length < 6) {
    store.dispatch(PasswordErrorAction(passwordError.i18n, screen));
    return false;
  } else {
    store.dispatch(PasswordErrorAction("", screen));
    return true;
  }
}

bool validateEmail(String email, Screen screen, Store<AppState> store) {
  RegExp exp = RegExp(EMAIL_PATTERN);
  if (!exp.hasMatch(email)) {
    store.dispatch(EmailErrorAction(emailError.i18n, screen));
    return false;
  } else {
    store.dispatch(EmailErrorAction("", screen));
    return true;
  }
}

bool validateName(String name, Screen screen, Store<AppState> store) {
  if (name.isEmpty) {
    store.dispatch(NameErrorAction(nameError.i18n, screen));
    return false;
  } else {
    store.dispatch(NameErrorAction("", screen));
    return true;
  }
}
