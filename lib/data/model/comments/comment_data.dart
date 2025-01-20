import '../users/user.dart';
import 'reply.dart';

class CommentData {
  int id;
  int? parentId;
  int userId;
  String body;
  String uuid;
  String commentableType;
  String commentableId;
  bool verified;
  String createdAt;
  String updatedAt;
  User user;
  List<Reply>? replies;

  CommentData({
    required this.id,
    this.parentId,
    required this.userId,
    required this.body,
    required this.uuid,
    required this.commentableType,
    required this.commentableId,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.replies,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      id: json['id'],
      parentId: json['parent_id'],
      userId: json['user_id'],
      body: json['body'],
      uuid: json['uuid'],
      commentableType: json['commentable_type'],
      commentableId: json['commentable_id'],
      verified: json['verified'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
      replies: List<Reply>.from(json['replies'].map((x) => Reply.fromJson(x))),
    );
  }
}
