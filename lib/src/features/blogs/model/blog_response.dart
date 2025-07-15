import 'dart:convert';

class BlogsResponse {
  List<Blogs>? data;
  Links? links;
  Meta? meta;
  bool? success;
  bool? result;
  int? status;

  BlogsResponse({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.result,
    this.status,
  });

  factory BlogsResponse.fromJson(String str) => BlogsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogsResponse.fromMap(Map<String, dynamic> json) => BlogsResponse(
    data: json["data"] == null ? [] : List<Blogs>.from(json["data"]!.map((x) => Blogs.fromMap(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    success: json["success"],
    result: json["result"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "success": success,
    "result": result,
    "status": status,
  };
}

class Blogs {
  int? id;
  String? title;
  String? slug;
  List<String>? tags;
  int? readingTime;
  int? views;
  String? banner;
  String? blogCategoryTitle;
  String? body;
  String? createdAt;

  Blogs({
    this.id,
    this.title,
    this.slug,
    this.tags,
    this.readingTime,
    this.views,
    this.banner,
    this.blogCategoryTitle,
    this.body,
    this.createdAt,
  });

  factory Blogs.fromJson(String str) => Blogs.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Blogs.fromMap(Map<String, dynamic> json) => Blogs(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    readingTime: json["reading_time"],
    views: json["views"],
    banner: json["banner"],
    blogCategoryTitle: json["blog_category_title"],
    body: json["body"],
    createdAt: json["create_date"] ,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "reading_time": readingTime,
    "views": views,
    "banner": banner,
    "blog_category_title": blogCategoryTitle,
    "body": body,
    "create_date": createdAt,
  };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  dynamic path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}
