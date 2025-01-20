import 'package:dartz/dartz.dart';

import '../../../data/model/profile/responseData.dart';

abstract class HandelState {}

class HandelInitState extends HandelState {}

class HandelLoadingState extends HandelState {}

class HandelUnauthorizedState extends HandelState {}

class HandelResponseState extends HandelState {
  Either<String, ResponseData> getProfile;
  HandelResponseState(this.getProfile);
}
