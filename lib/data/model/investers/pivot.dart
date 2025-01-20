class Pivot {
  int? userId;
  int? projectId;
  int? amount;
  int? id;
  bool? public;
  String? createdAt;
  String? updatedAt;

  Pivot({
    this.userId,
    this.projectId,
    this.amount,
    this.id,
    this.public,
    this.createdAt,
    this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json['user_id'],
        projectId: json['project_id'],
        amount: json['amount'],
        id: json['id'],
        public: json['public'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'project_id': projectId,
        'amount': amount,
        'id': id,
        'public': public,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
