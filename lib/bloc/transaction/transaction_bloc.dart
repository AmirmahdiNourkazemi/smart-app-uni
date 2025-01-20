import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartfunding/data/repository/transaction_repository.dart';
import 'package:smartfunding/di/di.dart';

import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final ITransactionRepository _transationRepository = locator.get();
  TransactionBloc() : super(TransactionInitState()) {
    on(
      (event, emit) async {
        if (event is TransactionStartEvent) {
          emit(TransactionLoadingState());
          var getTransactions = await _transationRepository.getTransactions(
              event.perPage, event.page, event.status);
          emit(TransactionResponseState(getTransactions));
          //emit(ProjectLoadingState());
        }
        // } else if (event is GetTicketEvent) {
        //   emit(GetTicketLoadingState());
        //   var getTicket = await _ticketRepository.uuidTicket(event.uuid);
        //   emit(GetTicketResponseState(getTicket));
        // }
      },
    );
  }
}
