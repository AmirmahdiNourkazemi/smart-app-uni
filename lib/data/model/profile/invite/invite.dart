import 'package:smartfunding/data/model/profile/legal_person.dart';
import 'package:smartfunding/data/model/profile/private_person.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';

class Invites {
  int? id;
  int? inviterId;
  int? type;
  String? createdAt;
  String? uuid;
  PrivatePersonInfo? privatePersonInfo;
  LegalPersonInfo? legalPersonInfo;

  String? fullName;
  List<Project>? project;

  Invites({
    this.id,
    this.inviterId,
    this.type,
    this.uuid,
    this.createdAt,
    this.fullName,
    this.privatePersonInfo,
    this.legalPersonInfo,
    this.project,
  });

  factory Invites.fromJson(Map<String, dynamic> json) {
    return Invites(
      id: json['id'],
      inviterId: json['inviter_id'],
      type: json['type'],
      uuid: json['uuid'],
      privatePersonInfo: json['private_person_info'] != null
          ? PrivatePersonInfo.fromJson(json['private_person_info'])
          : null,
      legalPersonInfo: json['legal_person_info'] != null
          ? LegalPersonInfo.fromJson(json['legal_person_info'])
          : null,
      createdAt: json['created_at'],
      fullName: json['full_name'],
      project: (json['projects'] as List<dynamic>?)
          ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
