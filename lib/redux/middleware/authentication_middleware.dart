import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/models/authentication_status.dart';
import 'package:weekly_bible_trivia/models/signin_request.dart';
import 'package:weekly_bible_trivia/models/signup_request.dart';
import 'package:weekly_bible_trivia/models/user_firebase.dart';
import 'package:weekly_bible_trivia/redux/actions/authentication_action.dart';
import 'package:weekly_bible_trivia/redux/actions/transition_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'navigation_middleware.dart';

ThunkAction<AppState> createLogOutThunk() {
  return (Store<AppState> store) async {
    store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.loading));

    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.noLoaded));
      store.dispatch(updateScreenThunk(NavigateToHomeAction()));
    } catch (error) {
      print(error);
    }
  };
}

ThunkAction<AppState> createSignInThunk(SignInRequest request) {
  return (Store<AppState> store) async {
    store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.loading));

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user;
    try {
      store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.loading));
      user = (await _auth.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      ))
          .user;
      if (user != null) {
        store.dispatch(AuthSuccessfulAction(
            user: UserFirebase(user.displayName ?? '', user.email ?? '',
                user.uid, user.photoURL ?? '')));
        store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.loaded));
        store.dispatch(updateScreenThunk(NavigateToHomeAction()));
      }
    } on FirebaseAuthException catch (error) {
      store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.error));
      if (error.code == 'user-not-found') {
        store.dispatch(AuthErrorAction('No user found for that email.'));
      } else if (error.code == 'wrong-password') {
        store.dispatch(
            AuthErrorAction('Wrong password provided for that user.'));
      } else if (error.code == 'too-many-requests') {
        store.dispatch(
            AuthErrorAction('Try again later...'));
      } else {
        print(error);
      }
    }
  };
}

ThunkAction<AppState> createSignUpThunk(SignUpRequest request) {
  return (Store<AppState> store) async {
    store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.loaded));

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user;
    store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.loading));
    try {
      user = (await _auth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      ))
          .user;
      if (user != null) {
        user.updateDisplayName(request.name);
        store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.loaded));
        store.dispatch(AuthSuccessfulAction(
            user: UserFirebase(request.name, user.email ?? '', user.uid,
                user.photoURL ?? '')));
        store.dispatch(updateScreenThunk(NavigateToHomeAction()));
      }
    } on FirebaseAuthException catch (error) {
      store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.error));
      if (error.code == 'email-already-in-use') {
        store.dispatch(AuthErrorAction('This email is already in use.'));
      } else {
        print(error);
      }
    }
  };
}

ThunkAction<AppState> createInitAuthThunk() {
  return (Store<AppState> store) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.authStateChanges().listen((User? user) {
        if (user != null) {
          store.dispatch(AuthSuccessfulAction(
              user: UserFirebase(user.displayName ?? '', user.email ?? '',
                  user.uid, user.photoURL ?? '')));
          store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.loaded));
        }
      });
      store.dispatch(ChangeAuthStatusAction(AuthenticationStatus.noLoaded));
      //store.dispatch(updateScreenThunk(NavigateToHomeAction()));
    } catch (error) {
      print(error);
    }
  };
}
