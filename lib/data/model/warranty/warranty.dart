class Waranty {
  int? id;
  String? title;
  String? description;
  int? position;

  Waranty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    position = json['position'];
  }
}
