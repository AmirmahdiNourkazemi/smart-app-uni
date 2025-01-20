import 'package:dartz/dartz.dart';
import 'package:smartfunding/data/datasource/comment_datasource.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../model/comments/root_comment.dart';

abstract class ICommentRepository {
  Future<Either<String, Root>> getComments(String uuid);
  Future<Either<String, String>> storeComment(
    String uuid,
    String body,
    String? parentID,
  );
}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _commentDatasource = locator.get();
  @override
  Future<Either<String, String>> storeComment(
    String uuid,
    String body,
    String? parentID,
  ) async {
    try {
      var response = await _commentDatasource.storeComment(
        uuid,
        body,
        parentID,
      );
      return right('نظر شما با موفقیت ثبت شد');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  Future<Either<String, Root>> getComments(String uuid) async {
    try {
      var response = await _commentDatasource.getComments(uuid);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
