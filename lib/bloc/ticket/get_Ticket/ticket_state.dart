import 'package:dartz/dartz.dart';

import '../../../data/model/ticket/get_ticket.dart';
import '../../../data/model/tickets/pagination.dart';

abstract class TicketState {}

class TicketInitState extends TicketState {}

class TicketLoadingState extends TicketState {}

class GetTicketLoadingState extends TicketState {}

class TicketResponseState extends TicketState {
  Either<String, Pagination> getTicket;
  TicketResponseState(this.getTicket);
}

class GetTicketResponseState extends TicketState {
  Either<String, GetTicket> getTicket;
  GetTicketResponseState(this.getTicket);
}

class CloseTicketResponseState extends TicketState {
  Either<String, String> closeTicket;
  CloseTicketResponseState(this.closeTicket);
}
