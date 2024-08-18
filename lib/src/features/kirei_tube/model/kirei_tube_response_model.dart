import 'dart:convert';

class KireiTubeResponse {
  List<Datum>? data;
  bool? success;
  int? status;

  KireiTubeResponse({
    this.data,
    this.success,
    this.status,
  });

  factory KireiTubeResponse.fromJson(String str) => KireiTubeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KireiTubeResponse.fromMap(Map<String, dynamic> json) => KireiTubeResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "success": success,
    "status": status,
  };
}

class Datum {
  int? id;
  String? title;
  String? slug;
  String? categoryName;
  String? banner;
  String? shortDescription;
  String? description;
  String? video;
  Statistics? statistics;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.categoryName,
    this.banner,
    this.shortDescription,
    this.description,
    this.video,
    this.statistics,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    categoryName: json["category_name"],
    banner: json["banner"],
    shortDescription: json["short_description"],
    description: json["description"],
    video: json["video"],
    statistics: json["statistics"] == null ? null : Statistics.fromMap(json["statistics"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "category_name": categoryName,
    "banner": banner,
    "short_description": shortDescription,
    "description": description,
    "video": video,
    "statistics": statistics?.toMap(),
  };
}

class Statistics {
  String? viewCount;
  String? likeCount;
  String? favoriteCount;
  String? commentCount;

  Statistics({
    this.viewCount,
    this.likeCount,
    this.favoriteCount,
    this.commentCount,
  });

  factory Statistics.fromJson(String str) => Statistics.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Statistics.fromMap(Map<String, dynamic> json) => Statistics(
    viewCount: json["viewCount"],
    likeCount: json["likeCount"],
    favoriteCount: json["favoriteCount"],
    commentCount: json["commentCount"],
  );

  Map<String, dynamic> toMap() => {
    "viewCount": viewCount,
    "likeCount": likeCount,
    "favoriteCount": favoriteCount,
    "commentCount": commentCount,
  };
}
