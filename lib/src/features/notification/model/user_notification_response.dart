import 'dart:convert';

class UserNotificationResponse {
  bool? result;
  String? message;
  Data? data;

  UserNotificationResponse({
    this.result,
    this.message,
    this.data,
  });

  factory UserNotificationResponse.fromJson(String str) => UserNotificationResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserNotificationResponse.fromMap(Map<String, dynamic> json) => UserNotificationResponse(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "result": result,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  int? currentPage;
  List<UserNotification>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<UserNotification>.from(json["data"]!.map((x) => UserNotification.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class UserNotification {
  int? id;
  int? userId;
  String? title;
  String? description;
  dynamic type;
  String? image;
  String? route;
  String? btnName;
  dynamic seenAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserNotification({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.type,
    this.image,
    this.route,
    this.btnName,
    this.seenAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserNotification.fromJson(String str) => UserNotification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserNotification.fromMap(Map<String, dynamic> json) => UserNotification(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    description: json["description"],
    type: json["type"],
    image: json["image"],
    route: json["route"],
    btnName: json["btn_name"],
    seenAt: json["seen_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "description": description,
    "type": type,
    "seen_at": seenAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
