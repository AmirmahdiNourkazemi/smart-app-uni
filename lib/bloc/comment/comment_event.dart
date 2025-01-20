abstract class CommentEvent {}

class CommentInitEvent extends CommentEvent {}

class CommentGetEvent extends CommentEvent {
  String uuid;
  CommentGetEvent(this.uuid);
}

class CommentAddEvent extends CommentEvent {
  String uuid;
  String body;
  String? parentID;
  CommentAddEvent(this.uuid, this.body, {this.parentID});
}
