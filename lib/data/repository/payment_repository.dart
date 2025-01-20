import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartfunding/data/model/deposit/deposit_data.dart';
import 'package:smartfunding/data/model/wallet/wallet.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../datasource/payment_datasource.dart';

abstract class IPaymentRepository {
  Future<Either<String, String>> goToPayment(
      int project_id, String amount, bool fromWallet, bool public);
  Future<Either<String, String>> storeWithdraw(int amount, String iban);
  Future<Either<String, String>> paidWallet(
      String project_id, String amount, bool public);
  Future<Either<String, String>> depositWallet(String amount);
  Future<Either<String, String>> storeTrackDeposit(
      int projectId, int amount, String trackCode, String date, XFile image);
  Future<Either<String, Withdraw>> getWithdraw();
  Future<Either<String, DepositData>> getDeposit();
  // Future<Either<String, String>> paidWallet(String project_uuid_id, String unit_uuid_id, double area);
}

class PaymentRepository extends IPaymentRepository {
  @override
  final IPaymentDatasource _paymentDatasource = locator.get();
  Future<Either<String, String>> goToPayment(
      int project_id, String amount, bool fromWallet, bool public) async {
    try {
      var response = await _paymentDatasource.goToPayment(
          project_id, amount, fromWallet, public);

      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  Future<Either<String, String>> storeWithdraw(int amount, String iban) async {
    try {
      var response = await _paymentDatasource.storeWithdraw(amount, iban);
      return right('درخواست شما ارسال شد');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Withdraw>> getWithdraw() async {
    try {
      var response = await _paymentDatasource.getWithdraw();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> paidWallet(
      String project_id, String amount, bool public) async {
    try {
      var response =
          await _paymentDatasource.paidWallet(project_id, amount, public);

      return right('.پرداخت انجام شد');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> depositWallet(String amount) async {
    try {
      var response = await _paymentDatasource.depositWallet(amount);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> storeTrackDeposit(int projectId, int amount,
      String trackCode, String date, XFile image) async {
    try {
      var response = await _paymentDatasource.storeTrackDeposit(
          projectId, amount, trackCode, date, image);
      return right('ثبت فیش با موفقیت انجام شد');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  Future<Either<String, DepositData>> getDeposit() async {
    try {
      var response = await _paymentDatasource.getDeposit();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
