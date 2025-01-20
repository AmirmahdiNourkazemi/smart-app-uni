class UserProfileResponse {
  final String? fullName;
  final int? wallet;
  final String? message;

  UserProfileResponse({
    this.fullName,
    this.wallet,
    this.message,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      fullName: json['user']['full_name'] as String,
      wallet: json['user']['wallet'] as int,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'full_name': fullName,
        'wallet': wallet,
      },
      'message': message,
    };
  }
}
