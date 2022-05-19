import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/models/edit_profile_request.dart';
import 'package:weekly_bible_trivia/models/user_firebase.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/profile_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';

import 'navigation_middleware.dart';

ThunkAction<AppState> createEditProfileThunk(EditProfileRequest request) {
  return (Store<AppState> store) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    firebase_storage.FirebaseStorage _storage =
        firebase_storage.FirebaseStorage.instance;
    final User? user;
    store.dispatch(UpdateLoadingAction(true));
    try {
      user = _auth.currentUser;
      if (user != null) {
        var userId = user.uid;
        String photoURL = user.photoURL ?? DEFAULT_PHOTO_URL;

        if (request.imageFile != null) {
          photoURL = await uploadFile(request.imageFile!, _storage, userId);
        }
        user.updateDisplayName(request.name);
        user.updatePhotoURL(photoURL);

        store.dispatch(EditProfileSuccessfulAction(
            UserFirebase(request.name, user.email ?? '', user.uid, photoURL)));
        store.dispatch(
            updateScreenThunk(NavigateFromProfileToHomeScreenAction()));
      }
    } catch (error) {
      print(error);
    }
    store.dispatch(UpdateLoadingAction(false));
  };
}

Future<String> uploadFile(
    File file, FirebaseStorage storage, var userId) async {
  String downloadUrl = DEFAULT_PHOTO_URL;
  try {
    var uploadTask = await firebase_storage.FirebaseStorage.instance
        .ref("user/profile/$userId")
        .putFile(file);
    downloadUrl = await (uploadTask).ref.getDownloadURL();
  } catch (e) {
    print(e);
  }
  return downloadUrl;
}

