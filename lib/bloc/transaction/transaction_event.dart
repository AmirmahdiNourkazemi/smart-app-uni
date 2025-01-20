abstract class TransactionEvent {}

class TransactionStartEvent extends TransactionEvent {
  int perPage;
  int page;
  int status;
  TransactionStartEvent({this.perPage = 10, this.page = 1, this.status = 0});
}

class GetTransactionEvent extends TransactionEvent {
  String uuid;
  GetTransactionEvent(this.uuid);
}
