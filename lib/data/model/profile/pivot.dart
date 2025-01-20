class Pivot {
  int userId;
  int projectId;
  int amount;
  String? traceCode;
  String createdAt;
  String updatedAt;

  Pivot({
    required this.userId,
    required this.projectId,
    required this.amount,
    this.traceCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'],
      projectId: json['project_id'],
      amount: json['amount'],
      traceCode: json['trace_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
