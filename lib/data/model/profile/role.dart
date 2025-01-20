class Role {
  final int id;
  final String name;
  final String displayName;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  Role({
    required this.id,
    required this.name,
    required this.displayName,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      displayName: json['display_name'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
