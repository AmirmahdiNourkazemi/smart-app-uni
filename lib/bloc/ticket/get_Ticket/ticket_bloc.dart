import 'package:bloc/bloc.dart';
import 'package:smartfunding/bloc/ticket/get_Ticket/ticket_state.dart';
import '../../../data/repository/ticket_repository.dart';
import '../../../di/di.dart';
import 'ticket_event.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final ITicketRepository _ticketRepository = locator.get();
  TicketBloc() : super(TicketInitState()) {
    on(
      (event, emit) async {
        if (event is TicketStartEvent) {
          emit(TicketLoadingState());
          var getUnits =
              await _ticketRepository.getTicket(event.perPage, event.page);
          emit(TicketResponseState(getUnits));
          //emit(ProjectLoadingState());
        } else if (event is GetTicketEvent) {
          emit(GetTicketLoadingState());
          var getTicket = await _ticketRepository.uuidTicket(event.uuid);
          emit(GetTicketResponseState(getTicket));
        } else if (event is CloseTicketEvent) {
          var closeTicket = await _ticketRepository.closeTicket(event.uuid);
          emit(CloseTicketResponseState(closeTicket));
          emit(TicketLoadingState());
          var getUnits =
              await _ticketRepository.getTicket(event.perPage, event.page);
          emit(TicketResponseState(getUnits));
        }
      },
    );
  }
}
