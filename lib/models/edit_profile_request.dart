import 'dart:io';

class EditProfileRequest{
  String name;
  File? imageFile;
  EditProfileRequest(this.name, this.imageFile);
}