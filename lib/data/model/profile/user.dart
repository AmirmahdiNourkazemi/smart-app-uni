class User {
  int id;
  bool? type;
  String? email;
  String mobile;
  String? nationalCode;
  String uuid;
  String? fullName;
  bool isAdmin;
  // bool verified;
  int? wallet;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  //List<Iban>? ibans;

  User({
    required this.id,
    this.type,
    this.email,
    required this.mobile,
    this.nationalCode,
    required this.uuid,
    this.fullName,
    required this.isAdmin,

    // required this.verified,
    this.wallet,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,

    //this.ibans,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      type: json['user']['type'],
      email: json['user']['email'],
      mobile: json['user']['mobile'],
      nationalCode: json['user']['national_code'] ?? '',
      uuid: json['user']['uuid'],
      fullName: json['user']['name'],
      isAdmin: json['user']['is_admin'],
      //verified: json['user']['verified'],
      createdAt: json['user']['created_at'],
      updatedAt: json['user']['updated_at'],
      deletedAt: json['user']['deleted_at'],

      // ibans: ibanList,
    );
  }
}
