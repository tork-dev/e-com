import 'dart:convert';

class BlogsResponseModel {
  Data? data;
  bool? success;
  int? status;

  BlogsResponseModel({
    this.data,
    this.success,
    this.status,
  });

  factory BlogsResponseModel.fromJson(String str) => BlogsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogsResponseModel.fromMap(Map<String, dynamic> json) => BlogsResponseModel(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
    "success": success,
    "status": status,
  };
}

class Data {
  List<BlogCategoryList>? blogCategoryList;
  List<Post>? recentPosts;
  List<Post>? posts;
  int? totalCount;

  Data({
    this.blogCategoryList,
    this.recentPosts,
    this.posts,
    this.totalCount,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    blogCategoryList: json["blogCategoryList"] == null ? [] : List<BlogCategoryList>.from(json["blogCategoryList"]!.map((x) => BlogCategoryList.fromMap(x))),
    recentPosts: json["recentPosts"] == null ? [] : List<Post>.from(json["recentPosts"]!.map((x) => Post.fromMap(x))),
    posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromMap(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toMap() => {
    "blogCategoryList": blogCategoryList == null ? [] : List<dynamic>.from(blogCategoryList!.map((x) => x.toMap())),
    "recentPosts": recentPosts == null ? [] : List<dynamic>.from(recentPosts!.map((x) => x.toMap())),
    "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toMap())),
    "totalCount": totalCount,
  };
}

class BlogCategoryList {
  int? id;
  int? parentId;
  String? name;
  String? slug;
  int? order;
  int? isActive;
  dynamic createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  BlogCategoryList({
    this.id,
    this.parentId,
    this.name,
    this.slug,
    this.order,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory BlogCategoryList.fromJson(String str) => BlogCategoryList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogCategoryList.fromMap(Map<String, dynamic> json) => BlogCategoryList(
    id: json["id"],
    parentId: json["parent_id"],
    name: json["name"],
    slug: json["slug"],
    order: json["order"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "parent_id": parentId,
    "name": name,
    "slug": slug,
    "order": order,
    "is_active": isActive,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Post {
  int? id;
  String? author;
  int? comments;
  String? content;
  String? hashtags;
  dynamic date;
  String? slug;
  String? title;
  dynamic type;
  List<BlogCategory>? blogCategories;
  dynamic video;
  List<Picture>? picture;
  List<Picture>? smallPicture;
  String? createdAt;
  String? postedDate;

  Post({
    this.id,
    this.author,
    this.comments,
    this.content,
    this.hashtags,
    this.date,
    this.slug,
    this.title,
    this.type,
    this.blogCategories,
    this.video,
    this.picture,
    this.smallPicture,
    this.createdAt,
    this.postedDate,
  });

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
    id: json["id"],
    author: json["author"],
    comments: json["comments"],
    content: json["content"],
    hashtags: json["hashtags"],
    date: json["date"],
    slug: json["slug"],
    title: json["title"],
    type: json["type"],
    blogCategories: json["blog_categories"] == null ? [] : List<BlogCategory>.from(json["blog_categories"]!.map((x) => BlogCategory.fromMap(x))),
    video: json["video"],
    picture: json["picture"] == null ? [] : List<Picture>.from(json["picture"]!.map((x) => Picture.fromMap(x))),
    smallPicture: json["small_picture"] == null ? [] : List<Picture>.from(json["small_picture"]!.map((x) => Picture.fromMap(x))),
    createdAt: json["created_at"],
    postedDate: json["posted_date"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "author": author,
    "comments": comments,
    "content": content,
    "hashtags": hashtags,
    "date": date,
    "slug": slug,
    "title": title,
    "type": type,
    "blog_categories": blogCategories == null ? [] : List<dynamic>.from(blogCategories!.map((x) => x.toMap())),
    "video": video,
    "picture": picture == null ? [] : List<dynamic>.from(picture!.map((x) => x.toMap())),
    "small_picture": smallPicture == null ? [] : List<dynamic>.from(smallPicture!.map((x) => x.toMap())),
    "created_at": createdAt,
    "posted_date": postedDate,
  };
}

class BlogCategory {
  String? name;
  String? slug;
  BlogCategoryPivot? pivot;

  BlogCategory({
    this.name,
    this.slug,
    this.pivot,
  });

  factory BlogCategory.fromJson(String str) => BlogCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogCategory.fromMap(Map<String, dynamic> json) => BlogCategory(
    name: json["name"],
    slug: json["slug"],
    pivot: json["pivot"] == null ? null : BlogCategoryPivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "slug": slug,
    "pivot": pivot?.toMap(),
  };
}

class BlogCategoryPivot {
  dynamic blogCategoryId;
  int? blogId;

  BlogCategoryPivot({
    this.blogCategoryId,
    this.blogId,
  });

  factory BlogCategoryPivot.fromJson(String str) => BlogCategoryPivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogCategoryPivot.fromMap(Map<String, dynamic> json) => BlogCategoryPivot(
    blogCategoryId: json["blog_category_id"],
    blogId: json["blog_id"],
  );

  Map<String, dynamic> toMap() => {
    "blog_category_id": blogCategoryId,
    "blog_id": blogId,
  };
}

class Picture {
  String? url;
  int? width;
  int? height;
  PicturePivot? pivot;

  Picture({
    this.url,
    this.width,
    this.height,
    this.pivot,
  });

  factory Picture.fromJson(String str) => Picture.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Picture.fromMap(Map<String, dynamic> json) => Picture(
    url: json["url"],
    width: json["width"],
    height: json["height"],
    pivot: json["pivot"] == null ? null : PicturePivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "width": width,
    "height": height,
    "pivot": pivot?.toMap(),
  };
}

class PicturePivot {
  int? relatedId;
  String? uploadFileId;

  PicturePivot({
    this.relatedId,
    this.uploadFileId,
  });

  factory PicturePivot.fromJson(String str) => PicturePivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PicturePivot.fromMap(Map<String, dynamic> json) => PicturePivot(
    relatedId: json["related_id"],
    uploadFileId: json["upload_file_id"],
  );

  Map<String, dynamic> toMap() => {
    "related_id": relatedId,
    "upload_file_id": uploadFileId,
  };
}
