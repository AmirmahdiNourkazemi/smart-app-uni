import 'package:dartz/dartz.dart';

abstract class CheckLoginState {}

class CheckLoginStartState extends CheckLoginState {}

class CheckLoadingState extends CheckLoginState {}

class CheckLoginResponse extends CheckLoginState {
  Either<String, String> getCheck;
  CheckLoginResponse(this.getCheck);
}

class LoginWithFingerPrintState extends CheckLoginState {
  Either<String, String> getCheck;
  LoginWithFingerPrintState(this.getCheck);
}
