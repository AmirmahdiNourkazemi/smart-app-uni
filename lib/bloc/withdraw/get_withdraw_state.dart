import 'package:dartz/dartz.dart';
import 'package:smartfunding/data/model/wallet/wallet.dart';

abstract class GetWithdrawState {}

class GetWithdrawInitState extends GetWithdrawState {}

class GetWithdrawLoadingState extends GetWithdrawState {}

class GetWithdrawResponseState extends GetWithdrawState {
  Either<String, Withdraw> getWithdraw;
  GetWithdrawResponseState(this.getWithdraw);
}

class StoreWithdrawResponseState extends GetWithdrawState {
  Either<String, String> storeWithdraw;
  StoreWithdrawResponseState(this.storeWithdraw);
}
