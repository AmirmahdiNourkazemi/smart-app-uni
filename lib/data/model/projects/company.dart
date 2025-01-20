class Company {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String uuid;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  Company({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      uuid: json['uuid'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }
}
