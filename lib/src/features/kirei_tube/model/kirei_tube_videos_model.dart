import 'dart:convert';

class KireiTubeVideosListResponse {
  List<Datum>? data;
  bool? success;
  int? status;

  KireiTubeVideosListResponse({
    this.data,
    this.success,
    this.status,
  });

  factory KireiTubeVideosListResponse.fromJson(String str) => KireiTubeVideosListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KireiTubeVideosListResponse.fromMap(Map<String, dynamic> json) => KireiTubeVideosListResponse(
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
  String? banner;
  String? orientation;
  int? isPopular;
  String? video;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.banner,
    this.orientation,
    this.isPopular,
    this.video,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    banner: json["banner"],
    orientation: json["orientation"],
    isPopular: json["is_popular"],
    video: json["video"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "banner": banner,
    "orientation": orientation,
    "is_popular": isPopular,
    "video": video,
  };
}

class StatisticsClass {
  String? viewCount;
  String? likeCount;
  String? favoriteCount;
  String? commentCount;

  StatisticsClass({
    this.viewCount,
    this.likeCount,
    this.favoriteCount,
    this.commentCount,
  });

  factory StatisticsClass.fromJson(String str) => StatisticsClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatisticsClass.fromMap(Map<String, dynamic> json) => StatisticsClass(
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
