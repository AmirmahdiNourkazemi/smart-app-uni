import 'data.dart';
import 'link.dart';

class Withdraw {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Withdraw({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Withdraw.fromJson(Map<String, dynamic> json) {
    return Withdraw(
      currentPage: json['current_page'] ?? 0,
      data: List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
      firstPageUrl: json['first_page_url'] ?? '',
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      lastPageUrl: json['last_page_url'] ?? '',
      links: List<Link>.from(json['links'].map((x) => Link.fromJson(x))),
      nextPageUrl: json['next_page_url'],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 0,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}
