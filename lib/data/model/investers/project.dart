import 'image.dart';
import 'pivot.dart';

class Project {
  int? id;
  String? uuid;
  String? title;
  String? createdAt;
  String? startAt;
  String? finishAt;
  List<Image>? images;
  List<dynamic>? attachments;
  num? progressBar;
  List<dynamic>? videos;
  Pivot? pivot;

  Project({
    this.id,
    this.uuid,
    this.title,
    this.createdAt,
    this.startAt,
    this.finishAt,
    this.images,
    this.attachments,
    this.progressBar,
    this.videos,
    this.pivot,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['id'],
        uuid: json['uuid'],
        title: json['title'],
        createdAt: json['created_at'],
        startAt: json['start_at'],
        finishAt: json['finish_at'],
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        attachments: json['attachments'],
        progressBar: json['progress_bar'],
        videos: json['videos'],
        pivot: json['pivot'] != null
            ? Pivot.fromJson(json['pivot'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uuid': uuid,
        'title': title,
        'created_at': createdAt,
        'start_at': startAt,
        'finish_at': finishAt,
        'images': images?.map((e) => e.toJson()).toList(),
        'attachments': attachments,
        'progress_bar': progressBar,
        'videos': videos,
        'pivot': pivot?.toJson(),
      };
}
