import 'dart:convert';

class BlogCategories {
  List<Datum>? data;
  bool? success;
  bool? result;
  int? status;

  BlogCategories({
    this.data,
    this.success,
    this.result,
    this.status,
  });

  factory BlogCategories.fromJson(String str) => BlogCategories.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogCategories.fromMap(Map<String, dynamic> json) => BlogCategories(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    success: json["success"],
    result: json["result"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "success": success,
    "result": result,
    "status": status,
  };
}

class Datum {
  int? id;
  String? title;
  String? slug;
  int? total;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.total,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "total": total,
  };
}
