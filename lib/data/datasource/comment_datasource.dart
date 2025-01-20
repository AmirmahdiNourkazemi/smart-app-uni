import 'package:dio/dio.dart';
import 'package:smartfunding/di/di.dart';

import '../../utils/api_exeption.dart';
import '../../utils/auth_manager.dart';
import '../model/comments/root_comment.dart';

abstract class ICommentDatasource {
  Future<Root> getComments(String uuid);
  Future<void> storeComment(
    String uuid,
    String body,
    String? parentID,
  );
}

class CommentDatasource implements ICommentDatasource {
  @override
  final Dio _dio = locator.get();
  String token = AuthMnager.readAuth();
  Future<void> storeComment(
    String uuid,
    String body,
    String? parentID,
  ) async {
    try {
      var response = await _dio.post(
        '/projects/$uuid/comments',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: parentID == null
            ? {
                'body': body,

                // Convert parentID to string if not null
              }
            : {
                'body': body,
                'parent_id': parentID
                    .toString(), // Convert parentID to string if not null
              },
      );
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption(ex.toString(), 402);
    }
  }

  Future<Root> getComments(String uuid) async {
    try {
      var response = await _dio.get(
        '/projects/$uuid/comments',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      return Root.fromJson(response.data);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
