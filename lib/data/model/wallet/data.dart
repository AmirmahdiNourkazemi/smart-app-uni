import 'package:smartfunding/data/model/wallet/bank_account.dart';
import 'image.dart';

class Data {
  int id;
  int userId;
  int amount;
  int status;
  String uuid;
  String createdAt;
  String updatedAt;
  int ibanId;
  String refId;
  dynamic withdrawDate;
  List<ImageData> images;
  BankAccount? bankAccount;

  Data({
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.ibanId,
    required this.refId,
    required this.withdrawDate,
    required this.images,
    this.bankAccount,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      amount: json['amount'] ?? 0,
      status: json['status'] ?? 0,
      uuid: json['uuid'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      ibanId: json['iban_id'] ?? 0,
      refId: json['ref_id'] ?? '',
      withdrawDate: json['withdraw_date'],
      images: List<ImageData>.from(
          json['images'].map((x) => ImageData.fromJson(x))),
      bankAccount: json['bank_account'] != null
          ? BankAccount.fromJson(json['bank_account'])
          : null,
    );
  }
}
