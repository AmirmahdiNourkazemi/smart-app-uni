import 'user_admin.dart';

class UserData {
  User? user;
  String? token;
  String? refreshToken;
  UserData({this.user, this.token, this.refreshToken});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json),
      token: json['token'],
      refreshToken: json['refresh_token'],
    );
  }
}
