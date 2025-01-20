import 'package:smartfunding/data/model/users/user.dart';

import 'message.dart';

class GetTicket {
  int id;
  int userId;
  String title;
  String description;
  int category;
  int status;
  String uuid;
  String createdAt;
  String updatedAt;
  User user;
  List<Message> messages;

  GetTicket({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.messages,
  });

  factory GetTicket.fromJson(Map<String, dynamic> json) {
    return GetTicket(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      status: json['status'],
      uuid: json['uuid'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
      messages: json['messages'] != null
          ? List<Message>.from(json['messages'].map((x) => Message.fromJson(x)))
          : [], // Provide an empty list if `messages` is null
    );
  }
}
