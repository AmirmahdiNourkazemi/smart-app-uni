import 'package:dartz/dartz.dart';
import 'package:smartfunding/utils/api_exeption.dart';

import '../../di/di.dart';
import '../datasource/ticket_datasource.dart';
import '../model/ticket/get_ticket.dart';
import '../model/ticket_response/ticket_response.dart';
import '../model/tickets/pagination.dart';

abstract class ITicketRepository {
  Future<Either<String, TicketResponse>> createTicket(
    String title,
    String description,
    int category,
  );
  Future<Either<String, String>> storeMessage(
    String uuid,
    String text,
  );
  Future<Either<String, Pagination>> getTicket(int perPage, int page);
  Future<Either<String, GetTicket>> uuidTicket(String uuid);
  Future<Either<String, String>> closeTicket(String uuid);
}

class TicketRepository extends ITicketRepository {
  final ITicketDatasource _ticketDatasource = locator.get();
  @override
  Future<Either<String, TicketResponse>> createTicket(
      String title, String description, int category) async {
    try {
      var response =
          await _ticketDatasource.storeTicket(title, description, category);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  Future<Either<String, Pagination>> getTicket(int perPage, int page) async {
    try {
      var response = await _ticketDatasource.getTicket(perPage, page);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> storeMessage(String uuid, String text) async {
    try {
      var response = await _ticketDatasource.storeMessage(uuid, text);
      return right('پیام شما ارسال شد');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, GetTicket>> uuidTicket(String uuid) async {
    try {
      var response = await _ticketDatasource.uuidTicket(uuid);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> closeTicket(String uuid) async {
    try {
      var response = await _ticketDatasource.closeTicket(uuid);
      return right('تیکت بسته شد');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
