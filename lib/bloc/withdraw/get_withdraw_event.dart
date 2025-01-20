abstract class GetWithdrawEvent {}

class GetWithdrawStartEvent extends GetWithdrawEvent {}

class StoreWithdrawEvent extends GetWithdrawEvent {
  int amount;
  String iban;
  StoreWithdrawEvent(this.amount, this.iban);
}
