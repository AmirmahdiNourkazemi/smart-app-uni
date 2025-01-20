import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartfunding/data/model/wallet/wallet.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../../utils/auth_manager.dart';
import '../model/deposit/deposit_data.dart';

abstract class IPaymentDatasource {
  Future<String> goToPayment(
      int project_id, String amount, bool fromWallet, bool public);
  Future<void> paidWallet(String project_id, String amount, bool public);
  Future<String> depositWallet(String amount);
  Future<void> storeWithdraw(int amount, String iban);
  Future<void> storeTrackDeposit(
      int projectId, int amount, String trackCode, String date, XFile image);
  Future<Withdraw> getWithdraw();
  Future<DepositData> getDeposit();
}

class PaymentDatasource extends IPaymentDatasource {
  final Dio _dio = locator.get();
  String token = AuthMnager.readAuth();
  @override
  Future<String> goToPayment(
      int project_id, String amount, bool fromWallet, bool public) async {
    try {
      var response = await _dio.post('/gateway',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }),
          data: {
            'description': 'خرید طرح',
            'project_id': project_id,
            'amount': amount,
            'from_wallet': fromWallet,
            'public': public,
          });
      return response.data['url'];
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  Future<void> storeWithdraw(int amount, String iban) async {
    try {
      var response = await _dio.post('/withdraws',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }),
          data: {'amount': amount, 'iban': iban});
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<Withdraw> getWithdraw() async {
    try {
      var response = await _dio.get(
        '/withdraws',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      return Withdraw.fromJson(response.data);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<void> paidWallet(String project_id, String amount, bool public) async {
    try {
      var response = await _dio.put('/projects/$project_id/buy',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }),
          data: {
            'amount': amount,
            'public': public,
          });
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<String> depositWallet(String amount) async {
    try {
      var response = await _dio.post('/gateway',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }),
          data: {
            'description': 'خرید طرح',
            'amount': amount,
          });
      return response.data['url'];
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<void> storeTrackDeposit(int projectId, int amount, String trackCode,
      String date, XFile image) async {
    try {
      FormData formData = FormData.fromMap({
        'project_id': projectId,
        'amount': amount,
        'ref_id': trackCode,
        'deposit_date': date,
        'image': await MultipartFile.fromFile(image.path)
      });
      var response = await _dio.post('/deposits',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'content-type': 'multipart/form-data'
          }),
          data: formData);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  Future<DepositData> getDeposit() async {
    try {
      var response = await _dio.get('/deposits',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      return DepositData.fromJson(response.data);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  // @override
  // Future<void> paidWallet(
  //     String project_uuid_id, String unit_uuid_id, double area) async {
  //   try {
  //     var response =
  //         await _dio.put('/projects/$project_uuid_id/units/$unit_uuid_id/buy',
  //             options: Options(headers: {
  //               'Accept': 'application/json',
  //               'Authorization': 'Bearer $token',
  //             }),
  //             data: {
  //           'area': area,
  //         });
  //   } on DioException catch (ex) {
  //     throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
  //   } catch (ex) {
  //     throw ApiExeption('unknown error happend', 0);
  //   }
  // }
}
