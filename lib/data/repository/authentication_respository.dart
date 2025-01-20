import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../../utils/auth_manager.dart';
import '../datasource/authentication_datasource.dart';
import '../model/profile/user.dart';

abstract class IAuthenticationRepository {
  Future<Either<String, String>> login(
      String mobile, String nationalCode, String? refralCode, bool forceUpdate);
  Future<Either<String, String>> getcheckOtp(
      String mobile, String nationalCode, String sms, bool forceUpdate);
  Future<Either<String, String>> loginWithFingerPrint();
}

class AuthenticationRemote extends IAuthenticationRepository {
  final IAuthenthicationDatasource _datasource = locator.get();
  final SharedPreferences _sharedPreferences = locator.get();

  @override
  Future<Either<String, String>> getcheckOtp(
      String mobile, String nationalCode, String sms, bool forceUpdate) async {
    try {
      var checkOtp =
          await _datasource.getcheckOtp(mobile, nationalCode, sms, forceUpdate);
      if (checkOtp.token!.isNotEmpty &&
          checkOtp.user!.nationalCode != null &&
          checkOtp.user!.fullName != null) {
        await locator<AuthMnager>().saveToken(checkOtp.token!);
        await locator<AuthMnager>().saveRefreshToken(checkOtp.refreshToken!);
        await locator<AuthMnager>().saveNatCode(checkOtp.user!.nationalCode!);
        await locator<AuthMnager>().saveName(checkOtp.user!.fullName!);
        await locator<AuthMnager>().saveMobile(checkOtp.user!.mobile!);

        return right('ورود');
      } else {
        await locator<AuthMnager>().saveToken(checkOtp.token!);
        await locator<AuthMnager>().saveRefreshToken(checkOtp.refreshToken!);
        await locator<AuthMnager>().saveNatCode(checkOtp.user!.nationalCode!);
          await locator<AuthMnager>().saveMobile(checkOtp.user!.mobile!);
        return right('ثبت نام');
      }
    } on ApiExeption catch (ex) {
      return left(ex.getFarsiMessage());
    }
  }

  @override
  Future<Either<String, String>> login(String mobile, String nationalCode,
      String? refralCode, bool forceUpdate) async {
    try {
      var res = await _datasource.login(
          mobile, nationalCode, refralCode, forceUpdate);

      AuthMnager.removeRefral();
      return right('ورود');
    } on ApiExeption catch (ex) {
      return left(ex.getFarsiMessage());
    }
  }

  @override
  Future<Either<String, String>> loginWithFingerPrint() async {
    try {
      var res = await _datasource.loginWithFingerPrint();
      print(res.data);
      await locator<AuthMnager>().saveToken(res.data['token']);
      await locator<AuthMnager>().saveName(res.data['user']['full_name']);
      return right('ورود');
    } on ApiExeption catch (ex) {
      return left(ex.getFarsiMessage());
    }
  }
}
