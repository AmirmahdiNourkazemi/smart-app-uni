import 'package:dio/dio.dart';
import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../../utils/auth_manager.dart';
import '../model/otp/userData.dart';
import '../model/profile/user.dart';

abstract class IAuthenthicationDatasource {
  Future<void> login(
      String mobile, String nationalCode, String? refralCode, bool forceUpdate);

  Future<UserData> getcheckOtp(
      String mobile, String nationalCode, String sms, bool forceUpdate);

  Future<Response> loginWithFingerPrint();
}

class AuthenthicationDatasource extends IAuthenthicationDatasource {
  final Dio _dio = locator.get();
  String refreshToken = AuthMnager.readRefreshAuth();
  String token = AuthMnager.readAuth();

  @override
  Future<void> login(String mobile, String nationalCode, String? refralCode,
      bool forceUpdate) async {
    try {
      Response result = await _dio.post('/auth/login', data: {
        'mobile': mobile,
        'national_code': nationalCode,
      });
      locator<AuthMnager>().saveToken(result.data['token']);
      locator<AuthMnager>().saveName(result.data['user']['name']);
      locator<AuthMnager>().saveNatCode(result.data['user']['national_code']);
      locator<AuthMnager>().saveMobile(result.data['user']['mobile']);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode,
          status: 420);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<Response> loginWithFingerPrint() async {
    try {
      print(refreshToken);
      print(token);
      var result = await _dio.put('/auth/refresh',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $refreshToken'
          }));
      return result;
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<UserData> getcheckOtp(
      String mobile, String nationalCode, String sms, bool forceUpdate) async {
    try {
      var response = await _dio.post('/auth/check-otp', data: {
        'mobile': mobile,
        'national_code': nationalCode,
        'token': sms,
        'force_update': forceUpdate
      }); // Make the API request

      Map<String, dynamic> jsonData = response.data;
      return UserData.fromJson(jsonData);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw Exception(ex);
      // throw ApiExeption('unknown error happend', 0);
    }
  }
}
