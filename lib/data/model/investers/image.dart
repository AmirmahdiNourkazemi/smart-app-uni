class Image {
  String? uuid;
  String? originalUrl;
  String? name;
  String? collectionName;

  Image({
    this.uuid,
    this.originalUrl,
    this.name,
    this.collectionName,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        uuid: json['uuid'],
        originalUrl: json['original_url'],
        name: json['name'],
        collectionName: json['collection_name'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'original_url': originalUrl,
        'name': name,
        'collection_name': collectionName,
      };
}
