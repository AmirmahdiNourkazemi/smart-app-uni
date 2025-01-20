import 'package:dio/dio.dart';
import 'package:smartfunding/data/model/transaction/transaction_data.dart';
import 'package:smartfunding/di/di.dart';
import 'package:smartfunding/utils/auth_manager.dart';

abstract class ITransactionDatasource {
  Future<TransactionData> getTransaction(int perPage, int page, int status);
}

class TransactionDtasource extends ITransactionDatasource {
  final Dio _dio = locator.get();
  String token = AuthMnager.readAuth();
  Future<TransactionData> getTransaction(
      int perPage, int page, int status) async {
    var response = await _dio.get(
      '/transactions',
      queryParameters: {
        'per_page': perPage,
        'page': page,
        // 'status': status,
      },
      options: Options(headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    if (response.statusCode == 200) {
      return TransactionData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }
}
