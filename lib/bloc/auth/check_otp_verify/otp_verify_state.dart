import 'package:dartz/dartz.dart';

abstract class OtpVerifyState {}

class OtpVerifyStartState extends OtpVerifyState {}

class OtpVerifyLoadingState extends OtpVerifyState {}

class OtpVerifyClearSms extends OtpVerifyState {}

class OtpVerifyResponse extends OtpVerifyState {
  Either<String, String> getcheckOtp;
  OtpVerifyResponse(this.getcheckOtp);
}
