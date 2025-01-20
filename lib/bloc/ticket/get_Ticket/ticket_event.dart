abstract class TicketEvent {}

class TicketStartEvent extends TicketEvent {
  int perPage;
  int page;
  TicketStartEvent({this.perPage = 10, this.page = 1});
}

class GetTicketEvent extends TicketEvent {
  String uuid;
  GetTicketEvent(this.uuid);
}

class CloseTicketEvent extends TicketEvent {
  String uuid;
  int perPage;
  int page;
  CloseTicketEvent(this.uuid, {this.perPage = 10, this.page = 1});
}
