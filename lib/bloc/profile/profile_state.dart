import 'package:dartz/dartz.dart';

import '../../data/model/investers/use_data.dart';
import '../../data/model/profile/responseData.dart';

abstract class ProfileState {}

class ProfileInitState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileUnauthorizedState extends ProfileState {}

class ProfileResponseState extends ProfileState {
  Either<String, ResponseData> getProfile;
  ProfileResponseState(this.getProfile);
}

class ProfileLogoutState extends ProfileState {
  Either<String, String> logout;
  ProfileLogoutState(this.logout);
}
