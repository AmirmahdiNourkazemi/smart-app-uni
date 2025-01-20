import 'package:dartz/dartz.dart';
import 'package:smartfunding/data/model/update/user_profile_response.dart';

abstract class EditProfileState {}

class EditProfileInitState extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileResponseState extends EditProfileState {
  Either<String, String> editProfile;
  EditProfileResponseState(this.editProfile);
}
