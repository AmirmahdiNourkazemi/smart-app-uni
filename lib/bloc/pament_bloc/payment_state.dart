import 'package:dartz/dartz.dart';
import 'package:smartfunding/data/model/deposit/deposit_data.dart';

abstract class PaymentState {}

class PaymentInitState extends PaymentState {}

class PaymentLoadingState extends PaymentState {}

class DisposeLoadingState extends PaymentState {}

class DisposeGetLoadingState extends PaymentState {}

class PaymentResponseState extends PaymentState {
  Either<String, String> goToPayment;
  PaymentResponseState(this.goToPayment);
}

class WalletResponseState extends PaymentState {
  Either<String, String> walletPaid;
  WalletResponseState(this.walletPaid);
}

class GetDepositResponseState extends PaymentState {
  Either<String, DepositData> getDeposit;
  GetDepositResponseState(this.getDeposit);
}

class DepositResponseState extends PaymentState {
  Either<String, String> goToPayment;
  DepositResponseState(this.goToPayment);
}

class StoreTrackDepositResponseState extends PaymentState {
  Either<String, String> goToPayment;
  StoreTrackDepositResponseState(this.goToPayment);
}
