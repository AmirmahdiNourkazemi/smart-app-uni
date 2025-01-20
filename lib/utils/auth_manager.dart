import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/di.dart';

class AuthMnager {
  //   static Future<void> init() async {
  //   // Initialize _sharedPreferences and authChangeNotifier.
  //   _sharedPreferences = await SharedPreferences.getInstance();

  //   authChangeNotifier.value = _sharedPreferences.getString('token') ?? null;
  //    authChangeNotifier.value = _sharedPreferences.getString('nationalCode') ?? null;
  // }
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final ValueNotifier<String?> refreshTokenNotifier =
      ValueNotifier(null);
  static final ValueNotifier<String?> nationalChangeNotifier =
      ValueNotifier(null);
  static final ValueNotifier<String?> nameChangeNotifier = ValueNotifier(null);
  static final ValueNotifier<bool> isFingerPrint = ValueNotifier(false);
  static final ValueNotifier<bool> valueChangeNotifier = ValueNotifier(
      nameChangeNotifier.value != '' &&
          nameChangeNotifier.value != null &&
          authChangeNotifier.value != '');
  static final ValueNotifier<String?> refralCodeNotifier = ValueNotifier('');
  static final ValueNotifier<DateTime?> forceUpdateDateNotfier =
      ValueNotifier(null);

static final ValueNotifier<String?> mobileChangeNotifier = ValueNotifier(null);

  static SharedPreferences sharedPreferences = locator.get();

  Future<void> saveMobile(String mobile) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("mobile", mobile);
    loadToken();
  }

  Future<void> loadMobile() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String token = sharedPreferences.getString("mobile") ?? "";
    mobileChangeNotifier.value = token;
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    loadToken();
  }

  Future<void> loadToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String token = sharedPreferences.getString("token") ?? "";
    authChangeNotifier.value = token;
  }

  Future<void> saveFingerPrint(bool check) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool("fingerPrint", check);
    loadFingerPrint();
  }

  Future<void> loadFingerPrint() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final bool check = sharedPreferences.getBool("fingerPrint") ?? false;
    isFingerPrint.value = check;
  }

  Future<void> saveRefreshToken(String token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("refreshToken", token);
    loadRefreshToken();
  }

  Future<void> loadRefreshToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String token = sharedPreferences.getString("refreshToken") ?? "";
    refreshTokenNotifier.value = token;
  }

  Future<void> saveNatCode(String natCode) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("natCode", natCode);
    loadNatCode();
  }

  Future<void> saveName(String name) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("name", name);
    loadName();
  }

  Future<void> savingRefralCode(String refralCode) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("refralCode", refralCode);
    loadRefralCode();
  }

  Future<void> loadRefralCode() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String refralCode = sharedPreferences.getString("refralCode") ?? "";
    refralCodeNotifier.value = refralCode;
  }

  Future<void> saveForceUpdateDate(String date) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("forceUpdate", date);
    loadForceUpdateDate();
  }

  Future<void> loadForceUpdateDate() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String forceUpdate = sharedPreferences.getString('forceUpdate') ?? "";
    forceUpdateDateNotfier.value = DateTime.parse(forceUpdate.toString());
  }

  Future<void> loadNatCode() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String natCode = sharedPreferences.getString("natCode") ?? "";
    nationalChangeNotifier.value = natCode;
  }

  Future<void> loadName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String name = sharedPreferences.getString("name") ?? "";
    nameChangeNotifier.value = name;
  }

  static String readAuth() {
    return sharedPreferences.getString('token') ?? '';
  }

  static String readRefreshAuth() {
    return sharedPreferences.getString('refreshToken') ?? '';
  }

  static String readNationalCode() {
    return sharedPreferences.getString('nationalCode') ?? '';
  }

  static String readForceUpdateDate() {
    return sharedPreferences.getString('forceUpdate') ?? 'null';
  }

  static void removeRefral() {
    refralCodeNotifier.value = '';
  }

  static void logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // sharedPreferences.clear();
    sharedPreferences.remove('token');

    sharedPreferences.remove('name');
    authChangeNotifier.value = "";
    nameChangeNotifier.value = "";
  }

  static bool isLogin() {
    String token = readAuth();
    String nationalCode = readNationalCode();
    if (token.isNotEmpty && nationalCode.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
