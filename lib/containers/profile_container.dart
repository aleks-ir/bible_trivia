import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redux/redux.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/translation_i18n.dart';
import 'package:weekly_bible_trivia/models/edit_profile_request.dart';
import 'package:weekly_bible_trivia/models/user_firebase.dart';
import 'package:weekly_bible_trivia/redux/middleware/authentication_middleware.dart';
import 'package:weekly_bible_trivia/redux/middleware/validation_middleware.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/widgets/buttons.dart';
import 'package:weekly_bible_trivia/widgets/error_validation.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';
import 'package:weekly_bible_trivia/widgets/text_form_fields.dart';


class ProfileContainer extends StatefulWidget {
  const ProfileContainer({Key? key}) : super(key: key);

  @override
  ProfileContainerState createState() {
    return ProfileContainerState();
  }
}

class ProfileContainerState extends State<ProfileContainer> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  bool _isInitName = false;
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, _ViewModel viewModel) {
          if (!_isInitName) {
            _nameController.text = viewModel.user.displayName;
            _isInitName = true;
          }
          return SizedBox.expand(
            child: Container(
              color: Color(viewModel.primaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      onBackgroundImageError: (exception, context) {
                        print(
                            'Cannot be loaded. Error msg : ${exception.toString()}');
                      },
                      backgroundColor: Color(viewModel.secondaryColor),
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : _getNetworkImage(viewModel.user.photoURL)
                              as ImageProvider,
                      radius: 70.0,
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 35.0,
                            height: 35.0,
                            child: RawMaterialButton(
                              fillColor: Color(viewModel.iconColor),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 17,
                              ),
                              onPressed: () async {
                                final status = await Permission.storage
                                    .request();
                                if (status.isGranted) {
                                  _getImageFile();
                                }
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthTextField(
                        textColor: Color(viewModel.textColor),
                        borderColor: Color(viewModel.textColor),
                        focusedBorderColor: Color(viewModel.iconColor),
                        controller: _nameController,
                        onChanged: (value) => viewModel.validateName(value),),
                    Align(
                      alignment: Alignment.centerRight,
                      child: viewModel.validStatus == ValidationStatus.error &&
                              viewModel.nameError.isNotEmpty
                          ? errorValidation(viewModel.nameError)
                          : const SizedBox(),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: authMaterialButton(
                          viewModel.loading
                              ? circularButtonProgressIndicator()
                              : Text(
                                  save.i18n,
                                ), () {
                        FocusScope.of(context).unfocus();
                        viewModel.editProfile(
                            EditProfileRequest(_nameController.text, _imageFile));
                      }, color: Color(viewModel.iconColor)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child:
                      authOutlinedButton(
                          signOut.i18n,
                          viewModel.navigateToSignOut,
                          textColor: Color(viewModel.iconColor),
                          color: Color(viewModel.iconColor))
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

NetworkImage _getNetworkImage(String photoURL) {
  NetworkImage image = NetworkImage(photoURL);
  return image;
}

class _ViewModel {
  final int iconColor;
  final int primaryColor;
  final int secondaryColor;
  final int textColor;
  final bool loading;
  final UserFirebase user;
  final String nameError;
  final ValidationStatus validStatus;

  final Function(String) validateName;
  final Function(EditProfileRequest) editProfile;
  final Function() navigateToSignOut;

  _ViewModel({
    required this.iconColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.textColor,
    required this.loading,
    required this.user,
    required this.nameError,
    required this.validStatus,
    required this.validateName,
    required this.editProfile,
    required this.navigateToSignOut,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      iconColor: store.state.themeSettingsState.iconColor,
      primaryColor: store.state.themeSettingsState.primaryColor,
      secondaryColor: store.state.themeSettingsState.secondaryColor,
      textColor: store.state.themeSettingsState.textColor,
      loading: store.state.editProfileState.loading,
      user: store.state.authenticationState.user,
      nameError: store.state.editProfileState.nameError,
      validStatus: store.state.editProfileState.validationStatus,
      validateName: (name) =>
          store.dispatch(validateNameThunk(name, Screen.editProfile)),
      editProfile: (request) =>
          store.dispatch(validateEditProfileThunk(request)),
      navigateToSignOut: () => store.dispatch(createLogOutThunk()),
    );
  }
}
