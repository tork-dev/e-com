import 'dart:convert';

class CommunityResponse {
  List<CommunityPost>? data;
  Links? links;
  Meta? meta;
  bool? success;
  int? status;

  CommunityResponse({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  factory CommunityResponse.fromRawJson(String str) => CommunityResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommunityResponse.fromJson(Map<String, dynamic> json) => CommunityResponse(
    data: json["data"] == null ? [] : List<CommunityPost>.from(json["data"]!.map((x) => CommunityPost.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "success": success,
    "status": status,
  };
}

class CommunityPost {
  int? id;
  int? customerId;
  String? customerName;
  String? description;
  List<dynamic>? products;
  String? banner;
  String? hashtags;
  String? date;
  bool? isLike;
  int? likeCount;
  int? commentsCount;
  List<AllComment>? allComments;

  CommunityPost({
    this.id,
    this.customerId,
    this.customerName,
    this.description,
    this.products,
    this.banner,
    this.hashtags,
    this.date,
    this.isLike,
    this.likeCount,
    this.commentsCount,
    this.allComments,
  });

  factory CommunityPost.fromRawJson(String str) => CommunityPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommunityPost.fromJson(Map<String, dynamic> json) => CommunityPost(
    id: json["id"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    description: json["description"],
    products: json["products"] == null ? [] : List<dynamic>.from(json["products"]!.map((x) => x)),
    banner: json["banner"],
    hashtags: json["hashtags"],
    date: json["date"],
    isLike: json["is_like"],
    likeCount: json["like_count"],
    commentsCount: json["comments_count"],
    allComments: json["all_comments"] == null ? [] : List<AllComment>.from(json["all_comments"]!.map((x) => AllComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "customer_name": customerName,
    "description": description,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x)),
    "banner": banner,
    "hashtags": hashtags,
    "date": date,
    "is_like": isLike,
    "like_count": likeCount,
    "comments_count": commentsCount,
    "all_comments": allComments == null ? [] : List<dynamic>.from(allComments!.map((x) => x.toJson())),
  };
}

class AllComment {
  int? id;
  dynamic parentId;
  int? customerId;
  int? postId;
  String? comment;
  int? order;
  int? isActive;
  dynamic createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? customerName;
  String? date;

  AllComment({
    this.id,
    this.parentId,
    this.customerId,
    this.postId,
    this.comment,
    this.order,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.customerName,
    this.date,
  });

  factory AllComment.fromRawJson(String str) => AllComment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllComment.fromJson(Map<String, dynamic> json) => AllComment(
    id: json["id"],
    parentId: json["parent_id"],
    customerId: json["customer_id"],
    postId: json["post_id"],
    comment: json["comment"],
    order: json["order"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    customerName: json["customer_name"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "customer_id": customerId,
    "post_id": postId,
    "comment": comment,
    "order": order,
    "is_active": isActive,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "customer_name": customerName,
    "date": date,
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

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
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

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
