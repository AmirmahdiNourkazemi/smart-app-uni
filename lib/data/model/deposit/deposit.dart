class Deposit {
  final int id;
  final int userId;
  final int amount;
  final int status;
  final String uuid;
  final String refId;
  final String depositDate;
  final String createdAt;
  final String updatedAt;
  // final List<String> images;

  Deposit({
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    required this.uuid,
    required this.refId,
    required this.depositDate,
    required this.createdAt,
    required this.updatedAt,
    // required this.images,
  });

  factory Deposit.fromJson(Map<String, dynamic> json) {
    return Deposit(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'],
      status: json['status'],
      uuid: json['uuid'],
      refId: json['ref_id'],
      depositDate: json['deposit_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      // images: (json['images'] as List).map((item) => item.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'status': status,
      'uuid': uuid,
      'ref_id': refId,
      'deposit_date': depositDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
      // 'images': images,
    };
  }
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
