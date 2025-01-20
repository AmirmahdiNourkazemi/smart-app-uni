import 'package:smartfunding/data/model/profile/unit.dart';
import 'package:smartfunding/data/model/profile/user.dart';

class ResponseData {
  User user;
  List<Unit>? units;

  ResponseData({
    required this.user,
    this.units,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      user: User.fromJson(json),
      units: List<Unit>.from(json['projects'].map((x) => Unit.fromJson(x))),
    );
  }
}
