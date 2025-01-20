abstract class CreateTicketEvent {}

class CreateTicketStartEvent extends CreateTicketEvent {}

class CreateTicketClickedEvent extends CreateTicketEvent {
  String title;
  String description;
  int category;
  CreateTicketClickedEvent(this.title, this.description, this.category);
}

class ShowMessageEvent extends CreateTicketEvent {}

class CreateMessageClickedEvent extends CreateTicketEvent {
  String text;
  String uuid;
  CreateMessageClickedEvent(this.uuid, this.text);
}
