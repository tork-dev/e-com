import 'dart:convert';

class KireiTubeHomeResponse {
  Shorts? videos;
  Shorts? shorts;
  List<Playlist>? playlists;
  bool? success;
  int? status;

  KireiTubeHomeResponse({
    this.videos,
    this.shorts,
    this.playlists,
    this.success,
    this.status,
  });

  factory KireiTubeHomeResponse.fromJson(String str) => KireiTubeHomeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KireiTubeHomeResponse.fromMap(Map<String, dynamic> json) => KireiTubeHomeResponse(
    videos: json["videos"] == null ? null : Shorts.fromMap(json["videos"]),
    shorts: json["shorts"] == null ? null : Shorts.fromMap(json["shorts"]),
    playlists: json["playlists"] == null ? [] : List<Playlist>.from(json["playlists"]!.map((x) => Playlist.fromMap(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "videos": videos?.toMap(),
    "shorts": shorts?.toMap(),
    "playlists": playlists == null ? [] : List<dynamic>.from(playlists!.map((x) => x.toMap())),
    "success": success,
    "status": status,
  };
}

class Playlist {
  int? id;
  String? title;
  String? slug;
  String? banner;
  String? visibility;
  String? description;

  Playlist({
    this.id,
    this.title,
    this.slug,
    this.banner,
    this.visibility,
    this.description,
  });

  factory Playlist.fromJson(String str) => Playlist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Playlist.fromMap(Map<String, dynamic> json) => Playlist(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    banner: json["banner"],
    visibility: json["visibility"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "banner": banner,
    "visibility": visibility,
    "description": description,
  };
}

class Shorts {
  List<Datum>? data;

  Shorts({
    this.data,
  });

  factory Shorts.fromJson(String str) => Shorts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Shorts.fromMap(Map<String, dynamic> json) => Shorts(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? id;
  String? title;
  String? slug;
  dynamic categoryName;
  String? banner;
  String? orientation;
  String? shortDescription;
  int? isPopular;
  String? video;
  List<dynamic>? statistics;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.categoryName,
    this.banner,
    this.orientation,
    this.shortDescription,
    this.isPopular,
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
    orientation: json["orientation"],
    shortDescription: json["short_description"],
    isPopular: json["is_popular"],
    video: json["video"],
    statistics: json["statistics"] == null ? [] : List<dynamic>.from(json["statistics"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "category_name": categoryName,
    "banner": banner,
    "orientation": orientation,
    "short_description": shortDescription,
    "is_popular": isPopular,
    "video": video,
    "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x)),
  };
}
