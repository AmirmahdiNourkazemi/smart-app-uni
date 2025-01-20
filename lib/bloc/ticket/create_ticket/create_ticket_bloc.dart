import 'package:bloc/bloc.dart';
import 'package:smartfunding/bloc/ticket/create_ticket/create_ticket_state.dart';

import '../../../data/repository/ticket_repository.dart';
import '../../../di/di.dart';
import 'create_ticket_event.dart';

class CreateTicketBloc extends Bloc<CreateTicketEvent, CreateTicketState> {
  final ITicketRepository _ticketRepository = locator.get();
  CreateTicketBloc() : super(CreateTicketInitState()) {
    on(
      (event, emit) async {
        if (event is CreateTicketStartEvent) {
          emit(CreateTicketInitState());
        } else if (event is CreateTicketClickedEvent) {
          emit(CreateTicketLoadingState());
          var response = await _ticketRepository.createTicket(
            event.title,
            event.description,
            event.category,
          );
          emit(CreateTicketResponseState(response));
        } else if (event is CreateMessageClickedEvent) {
          emit(CreateTicketLoadingState());
          var res =
              await _ticketRepository.storeMessage(event.uuid, event.text);
          emit(CreateMessageResponseState(res));
        } else if (event is ShowMessageEvent) {
          emit(CreateTicketLoadingState());
          //emit(ShowMessageState());
        }
      },
    );
  }
}
