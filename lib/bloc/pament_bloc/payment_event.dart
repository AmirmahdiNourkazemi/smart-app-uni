import 'package:image_picker/image_picker.dart';

abstract class PaymentEvent {}

class PaymentStartEvent extends PaymentEvent {}

class PaymentButtonClikedEvent extends PaymentEvent {
  int project_id;
  String amount;
  bool fromWallet;
  bool public;
  PaymentButtonClikedEvent(
    this.project_id,
    this.amount,
    this.fromWallet,
    this.public,
  );
}

class WalletPaidEvent extends PaymentEvent {
  String projectUuid;
  String amount;
  bool public;
  WalletPaidEvent(this.projectUuid, this.amount, this.public);
}

class StoreTrackDepositEvent extends PaymentEvent {
  int projectId;
  int amount;
  String trackCode;
  String date;
  XFile image;
  StoreTrackDepositEvent(
      this.projectId, this.amount, this.trackCode, this.date, this.image);
}

class DipositWalletEvent extends PaymentEvent {
  String amount;
  DipositWalletEvent(this.amount);
}

class GetDepositEvent extends PaymentEvent {
  GetDepositEvent();
}
