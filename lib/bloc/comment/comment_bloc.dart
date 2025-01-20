import 'package:bloc/bloc.dart';
import 'package:smartfunding/bloc/comment/comment_event.dart';
import 'package:smartfunding/bloc/comment/comment_state.dart';
import 'package:smartfunding/data/repository/comment_repository.dart';

import '../../di/di.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _commentRepository = locator.get();
  CommentBloc() : super(CommentInitial()) {
    on(
      (event, emit) async {
        if (event is CommentInitEvent) {
          emit(CommentInitial());
        } else if (event is CommentAddEvent) {
          emit(CommentLoading());
          var response = await _commentRepository.storeComment(
              event.uuid, event.body, event.parentID);
          emit(CommentStoreResponseState(response));
          emit(CommentGetLoading());
          var getComment = await _commentRepository.getComments(event.uuid);
          emit(CommentResponseState(getComment));
        }
        if (event is CommentGetEvent) {
          emit(CommentGetLoading());
          var getComment = await _commentRepository.getComments(event.uuid);
          emit(CommentResponseState(getComment));
        }
      },
    );
  }
}
