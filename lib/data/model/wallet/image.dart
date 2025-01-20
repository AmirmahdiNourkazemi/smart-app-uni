class ImageData {
  String uuid;
  String originalUrl;
  String name;
  String collectionName;

  ImageData({
    required this.uuid,
    required this.originalUrl,
    required this.name,
    required this.collectionName,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      uuid: json['uuid'] ?? '',
      originalUrl: json['original_url'] ?? '',
      name: json['name'] ?? '',
      collectionName: json['collection_name'] ?? '',
    );
  }
}
