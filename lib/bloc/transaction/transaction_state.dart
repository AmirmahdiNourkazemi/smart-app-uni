import 'package:dartz/dartz.dart';
import 'package:smartfunding/data/model/transaction/transaction_data.dart';

abstract class TransactionState {}

class TransactionInitState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class GetTransactionLoadingState extends TransactionState {}

class TransactionResponseState extends TransactionState {
  Either<String, TransactionData> getTransaction;
  TransactionResponseState(this.getTransaction);
}

// class GetTicketResponseState extends TransactionState {
//   Either<String , GetTicket> getTicket;
//   GetTicketResponseState(this.getTicket);
// }
