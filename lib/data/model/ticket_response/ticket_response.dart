class TicketResponse {
  final String title;
  final String description;
  final int category;
  final int userId;
  final String uuid;
  final String updatedAt;
  final String createdAt;
  final int id;

  TicketResponse({
    required this.title,
    required this.description,
    required this.category,
    required this.userId,
    required this.uuid,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) {
    return TicketResponse(
      title: json['title'],
      description: json['description'],
      category: json['category'],
      userId: json['user_id'],
      uuid: json['uuid'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}
