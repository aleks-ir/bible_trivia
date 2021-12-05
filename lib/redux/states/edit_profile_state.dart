import 'package:meta/meta.dart';
import 'package:weekly_bible_trivia/global/enums.dart';

@immutable
class EditProfileState {
  final bool loading;
  final ValidationStatus validationStatus;
  final String nameError;

  EditProfileState(
      {required this.loading,
        required this.validationStatus,
      required this.nameError,});

  EditProfileState copyWith({
    bool? loading,
    ValidationStatus? validationStatus,
    String? nameError
  }) {
    return EditProfileState(
      loading: loading ?? this.loading,
      validationStatus: validationStatus ?? this.validationStatus,
      nameError: nameError ?? this.nameError,
    );
  }

  factory EditProfileState.initial() {
    return EditProfileState(
      loading: false,
      validationStatus: ValidationStatus.success,
      nameError: "",
    );
  }
}
