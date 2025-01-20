abstract class CheckLoginEvent {}

class CheckLoginInitEvent extends CheckLoginEvent {}

class CheckLoginButtonClick extends CheckLoginEvent {
  String nationalCode;
  String? refralCode;
  bool forceUpdate;
  String mobile;
  CheckLoginButtonClick(this.mobile, this.nationalCode, this.refralCode,
      {this.forceUpdate = false});
}

class LoginWithFingerPrintEvent extends CheckLoginEvent {}
