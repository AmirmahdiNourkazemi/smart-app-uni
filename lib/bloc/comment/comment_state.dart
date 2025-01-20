import 'package:dartz/dartz.dart';

import '../../data/model/comments/root_comment.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentGetLoading extends CommentState {}

class CommentResponseState extends CommentState {
  Either<String, Root> getComments;
  CommentResponseState(this.getComments);
}

class CommentStoreResponseState extends CommentState {
  Either<String, String> response;
  CommentStoreResponseState(this.response);
}
