import 'dart:convert';

class KireiTubeVideosPlaylistResponse {
  List<Datum>? data;
  Links? links;
  Meta? meta;
  bool? success;
  int? status;

  KireiTubeVideosPlaylistResponse({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  factory KireiTubeVideosPlaylistResponse.fromJson(String str) => KireiTubeVideosPlaylistResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KireiTubeVideosPlaylistResponse.fromMap(Map<String, dynamic> json) => KireiTubeVideosPlaylistResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    links: json["links"] == null ? null : Links.fromMap(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "links": links?.toMap(),
    "meta": meta?.toMap(),
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
  int? videoCount;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.banner,
    this.visibility,
    this.description,
    this.videoCount
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
    videoCount: json["video_count"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "banner": banner,
    "visibility": visibility,
    "description": description,
    "video_count" : videoCount
  };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toMap() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
