import 'package:smartfunding/data/model/profile/pivot.dart';
import 'package:smartfunding/data/model/profile/projectDetails.dart';

import '../projects/Images.dart';
import '../projects/video.dart';
import 'trade.dart';
import 'transaction.dart';

class Unit {
  int? id;
  dynamic companyId;
  String? title;
  String? description;
  int? type;
  int? status;
  int? minInvest;
  num? fundNeeded;
  num? fundAchieved;
  String? expectedProfit;
  int? commission;
  int? priority;
  String? uuid;
  String? finishAt;
  String? startAt;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  // List<dynamic> images;
  // List<dynamic> attachments;
  int? progressBar;
  // List<dynamic>? videos;
  Pivot pivot;

  Unit({
    this.id,
    this.companyId,
    this.title,
    this.description,
    this.type,
    this.status,
    this.minInvest,
    this.fundNeeded,
    this.fundAchieved,
    this.expectedProfit,
    this.commission,
    this.priority,
    this.uuid,
    this.finishAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    // required this.images,
    // required this.attachments,
    this.progressBar,
    // this.videos,
    required this.pivot,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    // List<Image> imagesList = [];
    // if (json['images'] is List<dynamic>) {
    //   imagesList = List<Image>.from(
    //       json['images'].map((imageJson) => Image.fromJson(imageJson)));
    // }

    // ProjectDetails? projectDetails;
    // if (json['project'] != null) {
    //   projectDetails = ProjectDetails.fromJson(json['project']);
    // }
    return Unit(
      id: json["id"],

      title: json["title"],
      // address: json["address"],
      description: json["description"],
      type: json["type"],
      minInvest: json["min_invest"],
      fundNeeded: json["fund_needed"],
      fundAchieved: json["fund_achieved"],
      expectedProfit: json["expected_profit"],
      commission: json["commission"],
      priority: json["priority"],
      uuid: json["uuid"],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      status: json['status'],
      // images: imagesList,
      // videos: videosList,
      // attachments: json['attachments'],
      pivot: Pivot.fromJson(json['pivot']),
      // Parse Trades
    );
  }
}
