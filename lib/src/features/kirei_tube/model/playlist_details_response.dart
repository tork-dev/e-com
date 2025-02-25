import 'dart:convert';

class KireiTubePlaylistDetailsResponse {
  List<Datum>? data;
  bool? success;
  int? status;

  KireiTubePlaylistDetailsResponse({
    this.data,
    this.success,
    this.status,
  });

  factory KireiTubePlaylistDetailsResponse.fromJson(String str) => KireiTubePlaylistDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KireiTubePlaylistDetailsResponse.fromMap(Map<String, dynamic> json) => KireiTubePlaylistDetailsResponse(
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
  String? visibility;
  String? description;
  List<Video>? videos;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.banner,
    this.visibility,
    this.description,
    this.videos,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    banner: json["banner"],
    visibility: json["visibility"],
    description: json["description"],
    videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "banner": banner,
    "visibility": visibility,
    "description": description,
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toMap())),
  };
}

class Video {
  int? id;
  String? title;
  String? slug;
  String? banner;
  String? shortDescription;
  String? orientation;
  String? video;
  DateTime? createdAt;

  Video({
    this.id,
    this.title,
    this.slug,
    this.banner,
    this.shortDescription,
    this.orientation,
    this.video,
    this.createdAt
  });

  factory Video.fromJson(String str) => Video.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Video.fromMap(Map<String, dynamic> json) => Video(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    banner: json["banner"],
    shortDescription: json["short_description"],
    orientation: json["orientation"],
    video: json["video"],
    createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "banner": banner,
    "short_description": shortDescription,
    "orientation": orientation,
    "video": video,
    'created_at': createdAt?.toIso8601String(),
  };
}
