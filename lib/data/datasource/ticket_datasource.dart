import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../../utils/auth_manager.dart';
import '../model/ticket/get_ticket.dart';
import '../model/ticket_response/ticket_response.dart';
import '../model/tickets/pagination.dart';

abstract class ITicketDatasource {
  Future<TicketResponse> storeTicket(
    String title,
    String description,
    int category,
  );
  Future<void> storeMessage(
    String uuid,
    String text,
  );

  Future<Pagination> getTicket(int perPage, int page);
  Future<GetTicket> uuidTicket(String uuid);
  Future<void> closeTicket(String uuid);
}

class TicketDatasource extends ITicketDatasource {
  @override
  final Dio _dio = locator.get();
  String token = AuthMnager.readAuth();
  Future<TicketResponse> storeTicket(
    String title,
    String description,
    int category,
  ) async {
    try {
      var response = await _dio.post(
        '/tickets',
        data: {
          'title': title,
          'description': description,
          'category': category,
          'message': {'text': description},
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return TicketResponse.fromJson(response.data);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw Exception(ex);
    }
  }

  @override
  Future<void> storeMessage(String uuid, String text) async {
    try {
      var response = await _dio.post(
        '/tickets/$uuid/messages',
        data: {
          'text': text,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<Pagination> getTicket(int perPage, int page) async {
    var response = await _dio.get(
      '/tickets',
      queryParameters: {'per_page': perPage, 'page': page},
      options: Options(headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    if (response.statusCode == 200) {
      var res = Pagination.fromJson(response.data);
      return res;
    } else {
      throw Exception();
    }
    // try {

    // } on DioException catch (ex) {
    //   throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    // } catch (ex) {
    //   throw Exception(ex);
    //   //throw ApiExeption('unknown error happend', 0);
    // }
  }

  @override
  Future<GetTicket> uuidTicket(String uuid) async {
    try {
      Response response = await _dio.get(
        '/tickets/$uuid',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      return GetTicket.fromJson(response.data);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<void> closeTicket(String uuid) async {
    try {
      var response = await _dio.put(
        '/tickets/$uuid/close',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
