import 'link.dart';
import 'pivot.dart';
import 'project.dart';

class Pagination {
  int? currentPage;
  List<UserData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Pagination({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json['current_page'],
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
            .toList(),
        firstPageUrl: json['first_page_url'],
        from: json['from'],
        lastPage: json['last_page'],
        lastPageUrl: json['last_page_url'],
        links: (json['links'] as List<dynamic>?)
            ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
            .toList(),
        nextPageUrl: json['next_page_url'],
        path: json['path'],
        perPage: json['per_page'],
        prevPageUrl: json['prev_page_url'],
        to: json['to'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'data': data?.map((e) => e.toJson()).toList(),
        'first_page_url': firstPageUrl,
        'from': from,
        'last_page': lastPage,
        'last_page_url': lastPageUrl,
        'links': links?.map((e) => e.toJson()).toList(),
        'next_page_url': nextPageUrl,
        'path': path,
        'per_page': perPage,
        'prev_page_url': prevPageUrl,
        'to': to,
        'total': total,
      };
}

class UserData {
  int? id;
  int? type;
  String? email;
  String? mobile;
  String? nationalCode;
  String? uuid;
  bool? isAdmin;
  int? wallet;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? inviterId;
  String? fullName;
  dynamic legalPersonInfo;
  dynamic privatePersonInfo;
  List<Project>? projects;
  Pivot? pivot;

  UserData({
    this.id,
    this.type,
    this.email,
    this.mobile,
    this.nationalCode,
    this.uuid,
    this.isAdmin,
    this.wallet,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.inviterId,
    this.fullName,
    this.legalPersonInfo,
    this.privatePersonInfo,
    this.projects,
    this.pivot,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'],
        type: json['type'],
        email: json['email'],
        mobile: json['mobile'],
        nationalCode: json['national_code'],
        uuid: json['uuid'],
        isAdmin: json['is_admin'],
        wallet: json['wallet'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        deletedAt: json['deleted_at'],
        inviterId: json['inviter_id'],
        fullName: json['name'] ?? 'نامشخص',
        legalPersonInfo: json['legal_person_info'],
        privatePersonInfo: json['private_person_info'],
        projects: (json['projects'] as List<dynamic>?)
            ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
            .toList(),
        pivot: json['pivot'] != null
            ? Pivot.fromJson(json['pivot'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'email': email,
        'mobile': mobile,
        'national_code': nationalCode,
        'uuid': uuid,
        'is_admin': isAdmin,
        'wallet': wallet,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
        'inviter_id': inviterId,
        'full_name': fullName,
        'legal_person_info': legalPersonInfo,
        'private_person_info': privatePersonInfo,
        'projects': projects?.map((e) => e.toJson()).toList(),
        'pivot': pivot?.toJson(),
      };
}
