abstract class OtpVerifyEvent {}

class OtpVerifyInitEvent extends OtpVerifyEvent {}

class OtpVerifyResendCode extends OtpVerifyEvent {}

class OtpVerifyButtonClick extends OtpVerifyEvent {
  String mobile;
  String nationalCode;
  String token;
  bool forceUpdate;
  OtpVerifyButtonClick(this.mobile, this.nationalCode, this.token,
      {this.forceUpdate = false});
}
