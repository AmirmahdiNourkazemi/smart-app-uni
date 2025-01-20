import 'package:smartfunding/data/model/users/user.dart';

class Reply {
  final int? id; // Nullable integer
  final int? parentId; // Nullable integer
  final int? userId; // Nullable integer
  final String? body; // Nullable string
  final String? uuid; // Nullable string
  final String? commentableType; // Nullable string
  final String? commentableId; // Nullable string
  final bool? verified; // Nullable boolean
  final String? createdAt; // Nullable string
  final String? updatedAt; // Nullable string
  User? user;

  Reply({
    this.id,
    this.parentId,
    this.userId,
    this.body,
    this.uuid,
    this.commentableType,
    this.commentableId,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json['id'] as int?,
      parentId: json['parent_id'] as int?,
      userId: json['user_id'] as int?,
      body: json['body'] as String?,
      uuid: json['uuid'] as String?,
      commentableType: json['commentable_type'] as String?,
      commentableId: json['commentable_id'] as String?,
      verified: json['verified'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      user: User.fromJson(json['user']),
    );
  }
}
