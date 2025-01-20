import 'package:smartfunding/data/model/warranty/warranty.dart';

import 'Images.dart';
import 'attachments.dart';
import 'company.dart';
import 'contract.dart';
import 'video.dart';

class Project {
  int? id;
  dynamic companyId;
  String? title;
  String? description;
  int? type;
  int? status;
  num? minInvest;
  num? fundNeeded;
  num? fundAchieved;
  String? expectedProfit;
  num? commission;
  num? priority;
  String? uuid;
  String? finishAt;
  String? startAt;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<Image>? images;
  List<dynamic>? attachments;
  num? progressBar;
  List<dynamic>? videos;
  dynamic company;
  List<Map<String, dynamic>>? properties;
  List<Map<String, dynamic>>? timeTable;
  Contract? contract;
  int? warrantyId;
  Waranty? waranty;

  Project(
      {this.id,
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
      this.startAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.images,
      this.attachments,
      this.progressBar,
      this.videos,
      this.company,
      this.properties,
      this.timeTable,
      this.contract,
      this.warrantyId,
      this.waranty});

  factory Project.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> propertiesList = [];
    if (json['properties'] is List<dynamic>) {
      propertiesList = List<Map<String, dynamic>>.from(
        json['properties'].map((property) => {
              'key': property['key'],
              'value': property['value'],
            }),
      );
    }

    List<Map<String, dynamic>> timeTableList = [];
    if (json['time_table'] is List<dynamic>) {
      timeTableList = List<Map<String, dynamic>>.from(
        json['time_table'].map((timeTable) => {
              'title': timeTable['title'],
              'date': timeTable['date'],
            }),
      );
    }
    List<Image> imagesList = [];
    if (json['images'] is List<dynamic>) {
      imagesList = List<Image>.from(
          json['images'].map((imageJson) => Image.fromJson(imageJson)));
    }
    Company? company =
        json['company'] != null ? Company.fromJson(json['company']) : null;

    List<Video> videosList = [];
    if (json['videos'] is List<dynamic>) {
      videosList = List<Video>.from(
          json['videos'].map((videoJson) => Video.fromJson(videoJson)));
    }
    List<Attachment> attachmentsList = [];
    if (json['attachments'] is List<dynamic>) {
      attachmentsList = List<Attachment>.from(json['attachments']
          .map((attachmentJson) => Attachment.fromJson(attachmentJson)));
    }
    return Project(
      id: json["id"],
      companyId: json["company_id"],
      title: json["title"],
      // address: json["address"],
      description: json["description"],
      type: json["type"],
      minInvest: json["min_invest"],
      fundNeeded: json["fund_needed"],
      fundAchieved: json["fund_achieved"] ?? 0.00,
      expectedProfit: json["expected_profit"],
      uuid: json["uuid"],
      finishAt: json["finish_at"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      deletedAt: json["deleted_at"],
      images: imagesList,
      videos: videosList,
      status: json['status'],
      commission: json["commission"],
      startAt: json["start_at"] ?? json["created_at"],
      attachments: attachmentsList,
      progressBar: json["progress_bar"],
      company: company,
      properties: propertiesList,
      timeTable: timeTableList,
      contract:
          json['contract'] != null ? Contract.fromJson(json['contract']) : null,
      warrantyId: json['warranty_id'],
      waranty:
          json['warranty'] != null ? Waranty.fromJson(json['warranty']) : null,
    );
  }
  int calculateMonthDifference() {
    DateTime? startDateTime = startAt != null ? DateTime.parse(startAt!) : null;
    DateTime? finishDateTime =
        finishAt != null ? DateTime.parse(finishAt!) : null;

    if (startDateTime == null || finishDateTime == null) {
      return 0;
    }

    return _calculateMonthsDifference(startDateTime, finishDateTime);
  }

  int _calculateMonthsDifference(DateTime start, DateTime finish) {
    return finish.year * 12 + finish.month - (start.year * 12 + start.month);
  }

  String expectedInMounth() {
    double expect = double.parse(expectedProfit!);
    double mounth = 4;
    double devide = expect / mounth;
    return double.parse(devide.toString()).toStringAsFixed(2);
  }
}
