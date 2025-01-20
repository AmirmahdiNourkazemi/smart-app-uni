import 'package:dio/dio.dart';
import 'package:smartfunding/data/model/investers/use_data.dart';
import 'package:smartfunding/data/model/update/user_profile_response.dart';
import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../../utils/auth_manager.dart';
import '../model/profile/responseData.dart';
import '../model/profile/role.dart';
import '../model/profile/user.dart';

abstract class IProfileDatasource {
  Future<ResponseData> getProfile();
  Future<User> getNameUser();
  Future<void> logout();
  Future<Pagination> getInvites(String? projectUUid);
  Future<void> updateProfile(
      String name, int type, String mobile, String nationalCode);
}

class ProfileDatasource extends IProfileDatasource {
  final Dio _dio = locator.get();
  String token = AuthMnager.readAuth();
  Future<ResponseData> getProfile() async {
    try {
      Response response = await _dio.get(
        '/user/profile',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 401 || response.statusCode == 403) {
        AuthMnager.authChangeNotifier.value == '';
        AuthMnager.logout();
      }
      var res = ResponseData.fromJson(response.data);
      return res;
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    }
  }

  @override
  Future<User> getNameUser() async {
    Response response = await _dio.get(
      '/auth/profile',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> updateProfile(
      String name, int type, String mobile, String nationalCode) async {
    Response response = await _dio.post(
      '/auth/signin',
      data: {
        'name': name,
        'type': type == 1 ? true : false,
        'mobile': mobile,
        'national_code': nationalCode,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    ); // Make the API request
    if (response.statusCode == 201) {
      locator<AuthMnager>().saveToken(response.data['token']);
      locator<AuthMnager>().saveName(response.data['user']['name']);
      locator<AuthMnager>().saveNatCode(response.data['user']['national_code']);
      locator<AuthMnager>().saveMobile(response.data['user']['mobile']);
    } else {
      throw Exception();
    }
    // try {
    //   // Building bank_accounts list

    // } on DioException catch (ex) {

    // } catch (ex) {
    //   throw ApiExeption('unknown error happend', 0);
    // }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.put('/auth/logout',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<Pagination> getInvites(String? projectUUid) async {
    var res = await _dio.get('/auth/invites',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
        queryParameters:
            projectUUid != null ? {'project_uuid': projectUUid} : null);

    if (res.statusCode == 200) {
      return Pagination.fromJson(res.data);
    } else {
      throw Exception();
    }

    // try {
    //  var res = await _dio.get('/auth/invites',
    //       options: Options(headers: {
    //         'Accept': 'application/json',
    //         'Authorization': 'Bearer $token',
    //       }),
    //       queryParameters:
    //           projectUUid != null ? {'project_uuid': projectUUid} : null);
    //           print(Pagination.fromJson(res.data).data);
    //           return Pagination.fromJson(res.data);

    // }  on DioException catch (ex) {
    //   throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    // } catch (ex) {
    //   throw ApiExeption('unknown error happend', 0);
    // }
  }
}
