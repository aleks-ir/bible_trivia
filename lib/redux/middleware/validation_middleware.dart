import 'dart:async';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/constants/strings.dart';
import 'package:weekly_bible_trivia/models/validation_status.dart';
import 'package:weekly_bible_trivia/models/screens.dart';
import 'package:weekly_bible_trivia/models/signin_request.dart';
import 'package:weekly_bible_trivia/models/signup_request.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'authentication_middleware.dart';

const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';


ThunkAction<AppState> validateSignInThunk(SignInRequest request) {
  return (Store<AppState> store) {
    Screens screen = Screens.SIGNIN;
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
    Screens screen = Screens.SIGNUP;
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


ThunkAction<AppState> validatePassMatchThunk(String password, String confirmPassword, Screens screen,) {
  return (Store<AppState> store) {
    validatePassMatch(password, confirmPassword, screen, store);
  };
}

ThunkAction<AppState> validatePasswordThunk(String password, Screens screen) {
  return (Store<AppState> store) {
    validatePassword(password, screen, store);
  };
}

ThunkAction<AppState> validateEmailThunk(String email, Screens screen) {
  return (Store<AppState> store) {
    validateEmail(email, screen, store);
  };
}

ThunkAction<AppState> validateNameThunk(String name, Screens screen) {
  return (Store<AppState> store) {
    validateName(name, screen, store);
  };
}


bool validatePassMatch(String password, String confirmPassword,
    Screens screen, Store<AppState> store) {
  if (password != confirmPassword) {
    store.dispatch(RetypePasswordErrorAction(password_match_error, screen));
    return false;
  } else {
    store.dispatch(RetypePasswordErrorAction("", screen));
    return true;
  }
}

bool validatePassword(
    String password, Screens screen, Store<AppState> store) {
  if (password.length < 6) {
    store.dispatch(PasswordErrorAction(password_error, screen));
    return false;
  } else {
    store.dispatch(PasswordErrorAction("", screen));
    return true;
  }
}

bool validateEmail(String email, Screens screen, Store<AppState> store) {
  RegExp exp = RegExp(emailPattern);
  if (!exp.hasMatch(email)) {
    store.dispatch(EmailErrorAction(email_error, screen));
    return false;
  } else {
    store.dispatch(EmailErrorAction("", screen));
    return true;
  }
}

bool validateName(String name, Screens screen, Store<AppState> store) {
  if (name.isEmpty) {
    store.dispatch(NameErrorAction(name_error, screen));
    return false;
  } else {
    store.dispatch(NameErrorAction("", screen));
    return true;
  }
}
