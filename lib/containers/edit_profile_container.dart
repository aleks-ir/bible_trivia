import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/edit_profile_request.dart';
import 'package:weekly_bible_trivia/models/user_firebase.dart';
import 'package:weekly_bible_trivia/redux/middleware/validation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/circular_progress_indicator.dart';
import 'package:weekly_bible_trivia/widgets/error_validation.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields.dart';

class EditProfileContainer extends StatefulWidget {
  EditProfileContainer({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _EditProfileContainerState createState() => _EditProfileContainerState();
}

class _EditProfileContainerState extends State<EditProfileContainer> {

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  bool isInitName = false;
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          if (!isInitName) {
            _nameController.text = viewModel.user.displayName;
            isInitName = true;
          }
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) as ImageProvider : NetworkImage(viewModel.user.photoURL),
                      radius: 80.0,
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            child: RawMaterialButton(
                              fillColor: Colors.teal,
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {_getImageFile();},
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    authTextField(
                        color: Color(viewModel.textColor),
                        controller: _nameController,
                        onChanged: (value) => viewModel.validateName(value),
                        label: name.i18n),
                    Align(
                      alignment: Alignment.centerRight,
                      child: viewModel.validStatus == ValidationStatus.error &&
                              viewModel.nameError.isNotEmpty
                          ? errorValidation(viewModel.nameError)
                          : const SizedBox(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    authButton(viewModel.loading ? circularProgressIndicator() :
                        Text(
                          save.i18n,
                        ), () {
                      FocusScope.of(context).unfocus();
                      viewModel.editProfile(EditProfileRequest(
                          _nameController.text,
                          _imageFile));
                    }, color: Colors.brown),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _getImageFile() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        if(pickedFile != null){
          _imageFile = File(pickedFile.path);
        }
      });
    } catch (e) {
      print(e);
    }
  }

}


class _ViewModel {
  final int primaryColor;
  final int textColor;
  final bool loading;
  final UserFirebase user;
  final String nameError;
  final ValidationStatus validStatus;

  final Function(String) validateName;
  final Function(EditProfileRequest) editProfile;

  _ViewModel({
    required this.primaryColor,
    required this.textColor,
    required this.loading,
    required this.user,
    required this.nameError,
    required this.validStatus,
    required this.validateName,
    required this.editProfile,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      primaryColor: store.state.themeSettingsState.primaryColor,
      textColor: store.state.themeSettingsState.textColor,
      loading: store.state.editProfileState.loading,
      user: store.state.authenticationState.user,
      nameError: store.state.editProfileState.nameError,
      validStatus: store.state.editProfileState.validationStatus,
      validateName: (name) =>
          store.dispatch(validateNameThunk(name, Screen.editProfile)),
      editProfile: (request) =>
          store.dispatch(validateEditProfileThunk(request)),
    );
  }
}
