import 'package:dartz/dartz.dart';

import '../../../data/model/ticket_response/ticket_response.dart';

abstract class CreateTicketState {}

class CreateTicketInitState extends CreateTicketState {}

class CreateTicketLoadingState extends CreateTicketState {}

class CreateTicketResponseState extends CreateTicketState {
  Either<String, TicketResponse> response;
  CreateTicketResponseState(this.response);
}

class ShowMessageState extends CreateTicketState {}

class CreateMessageResponseState extends CreateTicketState {
  Either<String, String> response;
  CreateMessageResponseState(this.response);
}
