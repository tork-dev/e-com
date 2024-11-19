import 'dart:convert';

class KireiTubeVideosListResponse {
  List<VideoList>? data;
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
    data: json["data"] == null ? [] : List<VideoList>.from(json["data"]!.map((x) => VideoList.fromMap(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "success": success,
    "status": status,
  };
}

class VideoList {
  int? id;
  String? title;
  String? slug;
  String? banner;
  String? orientation;
  int? isPopular;
  String? video;

  VideoList({
    this.id,
    this.title,
    this.slug,
    this.banner,
    this.orientation,
    this.isPopular,
    this.video,
  });

  factory VideoList.fromJson(String str) => VideoList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoList.fromMap(Map<String, dynamic> json) => VideoList(
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
