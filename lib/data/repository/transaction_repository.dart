import 'package:dartz/dartz.dart';
import 'package:smartfunding/data/datasource/transaction_datasource.dart';
import 'package:smartfunding/data/model/transaction/transaction_data.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';

abstract class ITransactionRepository {
  Future<Either<String, TransactionData>> getTransactions(
      int perPage, int page, int status);
}

class TransactionRepository extends ITransactionRepository {
  final ITransactionDatasource _transactionDatasource = locator.get();
  @override
  Future<Either<String, TransactionData>> getTransactions(
      int perPage, int page, int status) async {
    try {
      var response =
          await _transactionDatasource.getTransaction(perPage, page, status);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
