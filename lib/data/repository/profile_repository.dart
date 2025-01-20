import 'package:dartz/dartz.dart';
import 'package:smartfunding/data/model/investers/use_data.dart';
import 'package:smartfunding/data/model/profile/role.dart';
import 'package:smartfunding/data/model/update/user_profile_response.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../../utils/auth_manager.dart';
import '../datasource/profile_datasouce.dart';
import '../model/profile/responseData.dart';
import '../model/profile/user.dart';

abstract class IProfileRepository {
  Future<Either<String, ResponseData>> getProfile();
  Future<Either<String, User>> getNameUser();
  Future<Either<String, String>> logout();
  Future<Either<String, Pagination>> getInvites(String? prjectUUid);
  Future<Either<String, String>> updateProfile(
      String name,
      int type,
      String mobile,
      String nationalCode);
}

class ProfileRepository extends IProfileRepository {
  final IProfileDatasource _profileDatasource = locator.get();

  @override
  Future<Either<String, ResponseData>> getProfile() async {
    try {
      var response = await _profileDatasource.getProfile();
      return right(response);
    } on ApiExeption catch (e) {
      if (e.code == 401) {
        AuthMnager.authChangeNotifier.value = '';
        AuthMnager.logout();
        return left('unauth');
      }
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, User>> getNameUser() async {
    try {
      var response = await _profileDatasource.getNameUser();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> updateProfile(
      String name,
      int type,
    String mobile,
      String nationalCode) async {
    try {
      var response = await _profileDatasource.updateProfile(
          name,
          type,
          mobile,
          nationalCode);
      
      return right('ثبت نام با موفقیت انجام شد');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا در ثبت نام');
    }
  }

  @override
  Future<Either<String, String>> logout() async {
    try {
      // var response = await _profileDatasource.logout();
      AuthMnager.logout();
      return right('خروج');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Pagination>> getInvites(String? prjectUUid) async {
    try {
      var response = await _profileDatasource.getInvites(prjectUUid);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
