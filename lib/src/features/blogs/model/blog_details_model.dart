import 'dart:convert';

class BlogDetailsResponseModel {
  int? id;
  int? categoryId;
  String? title;
  String? slug;
  String? shortDescription;
  String? description;
  String? banner;
  dynamic metaTitle;
  String? metaImg;
  String? metaDescription;
  dynamic metaKeywords;
  int? isActive;
  dynamic createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Post? post;
  List<RecentPostElement>? recentPosts;
  List<Category>? blogCategoryList;
  List<RecentPostElement>? relatedPosts;
  List<Comment>? blogComments;
  Category? category;

  BlogDetailsResponseModel({
    this.id,
    this.categoryId,
    this.title,
    this.slug,
    this.shortDescription,
    this.description,
    this.banner,
    this.metaTitle,
    this.metaImg,
    this.metaDescription,
    this.metaKeywords,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.post,
    this.recentPosts,
    this.blogCategoryList,
    this.relatedPosts,
    this.blogComments,
    this.category,
  });

  factory BlogDetailsResponseModel.fromJson(String str) => BlogDetailsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlogDetailsResponseModel.fromMap(Map<String, dynamic> json) => BlogDetailsResponseModel(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    slug: json["slug"],
    shortDescription: json["short_description"],
    description: json["description"],
    banner: json["banner"],
    metaTitle: json["meta_title"],
    metaImg: json["meta_img"],
    metaDescription: json["meta_description"],
    metaKeywords: json["meta_keywords"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    post: json["post"] == null ? null : Post.fromMap(json["post"]),
    recentPosts: json["recentPosts"] == null ? [] : List<RecentPostElement>.from(json["recentPosts"]!.map((x) => RecentPostElement.fromMap(x))),
    blogCategoryList: json["blogCategoryList"] == null ? [] : List<Category>.from(json["blogCategoryList"]!.map((x) => Category.fromMap(x))),
    relatedPosts: json["relatedPosts"] == null ? [] : List<RecentPostElement>.from(json["relatedPosts"]!.map((x) => RecentPostElement.fromMap(x))),
    blogComments: json["blog_comments"] == null ? [] : List<Comment>.from(json["blog_comments"]!.map((x) => Comment.fromMap(x))),
    category: json["category"] == null ? null : Category.fromMap(json["category"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "slug": slug,
    "short_description": shortDescription,
    "description": description,
    "banner": banner,
    "meta_title": metaTitle,
    "meta_img": metaImg,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "is_active": isActive,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "post": post?.toMap(),
    "recentPosts": recentPosts == null ? [] : List<dynamic>.from(recentPosts!.map((x) => x.toMap())),
    "blogCategoryList": blogCategoryList == null ? [] : List<dynamic>.from(blogCategoryList!.map((x) => x.toMap())),
    "relatedPosts": relatedPosts == null ? [] : List<dynamic>.from(relatedPosts!.map((x) => x.toMap())),
    "blog_comments": blogComments == null ? [] : List<dynamic>.from(blogComments!.map((x) => x)),
    "category": category?.toMap(),
  };
}

class Category {
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

  Category({
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

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
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
  dynamic date;
  String? slug;
  String? title;
  dynamic type;
  List<PostBlogCategory>? blogCategories;
  dynamic video;
  List<dynamic>? picture;
  List<dynamic>? smallPicture;

  Post({
    this.id,
    this.author,
    this.comments,
    this.content,
    this.date,
    this.slug,
    this.title,
    this.type,
    this.blogCategories,
    this.video,
    this.picture,
    this.smallPicture,
  });

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
    id: json["id"],
    author: json["author"],
    comments: json["comments"],
    content: json["content"],
    date: json["date"],
    slug: json["slug"],
    title: json["title"],
    type: json["type"],
    blogCategories: json["blog_categories"] == null ? [] : List<PostBlogCategory>.from(json["blog_categories"]!.map((x) => PostBlogCategory.fromMap(x))),
    video: json["video"],
    picture: json["picture"] == null ? [] : List<dynamic>.from(json["picture"]!.map((x) => x)),
    smallPicture: json["small_picture"] == null ? [] : List<dynamic>.from(json["small_picture"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "author": author,
    "comments": comments,
    "content": content,
    "date": date,
    "slug": slug,
    "title": title,
    "type": type,
    "blog_categories": blogCategories == null ? [] : List<dynamic>.from(blogCategories!.map((x) => x.toMap())),
    "video": video,
    "picture": picture == null ? [] : List<dynamic>.from(picture!.map((x) => x)),
    "small_picture": smallPicture == null ? [] : List<dynamic>.from(smallPicture!.map((x) => x)),
  };
}

class PostBlogCategory {
  String? name;
  String? slug;
  PurplePivot? pivot;

  PostBlogCategory({
    this.name,
    this.slug,
    this.pivot,
  });

  factory PostBlogCategory.fromJson(String str) => PostBlogCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostBlogCategory.fromMap(Map<String, dynamic> json) => PostBlogCategory(
    name: json["name"],
    slug: json["slug"],
    pivot: json["pivot"] == null ? null : PurplePivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "slug": slug,
    "pivot": pivot?.toMap(),
  };
}

class PurplePivot {
  int? blogCategoryId;
  int? blogId;

  PurplePivot({
    this.blogCategoryId,
    this.blogId,
  });

  factory PurplePivot.fromJson(String str) => PurplePivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurplePivot.fromMap(Map<String, dynamic> json) => PurplePivot(
    blogCategoryId: json["blog_category_id"],
    blogId: json["blog_id"],
  );

  Map<String, dynamic> toMap() => {
    "blog_category_id": blogCategoryId,
    "blog_id": blogId,
  };
}

class RecentPostElement {
  int? id;
  String? author;
  int? comments;
  String? content;
  dynamic date;
  String? slug;
  String? title;
  dynamic type;
  List<RecentPostBlogCategory>? blogCategories;
  dynamic video;
  List<Picture>? picture;
  List<Picture>? smallPicture;

  RecentPostElement({
    this.id,
    this.author,
    this.comments,
    this.content,
    this.date,
    this.slug,
    this.title,
    this.type,
    this.blogCategories,
    this.video,
    this.picture,
    this.smallPicture,
  });

  factory RecentPostElement.fromJson(String str) => RecentPostElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecentPostElement.fromMap(Map<String, dynamic> json) => RecentPostElement(
    id: json["id"],
    author: json["author"],
    comments: json["comments"],
    content: json["content"],
    date: json["date"],
    slug: json["slug"],
    title: json["title"],
    type: json["type"],
    blogCategories: json["blog_categories"] == null ? [] : List<RecentPostBlogCategory>.from(json["blog_categories"]!.map((x) => RecentPostBlogCategory.fromMap(x))),
    video: json["video"],
    picture: json["picture"] == null ? [] : List<Picture>.from(json["picture"]!.map((x) => Picture.fromMap(x))),
    smallPicture: json["small_picture"] == null ? [] : List<Picture>.from(json["small_picture"]!.map((x) => Picture.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "author": author,
    "comments": comments,
    "content": content,
    "date": date,
    "slug": slug,
    "title": title,
    "type": type,
    "blog_categories": blogCategories == null ? [] : List<dynamic>.from(blogCategories!.map((x) => x.toMap())),
    "video": video,
    "picture": picture == null ? [] : List<dynamic>.from(picture!.map((x) => x.toMap())),
    "small_picture": smallPicture == null ? [] : List<dynamic>.from(smallPicture!.map((x) => x.toMap())),
  };
}

class RecentPostBlogCategory {
  String? name;
  String? slug;
  FluffyPivot? pivot;

  RecentPostBlogCategory({
    this.name,
    this.slug,
    this.pivot,
  });

  factory RecentPostBlogCategory.fromJson(String str) => RecentPostBlogCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecentPostBlogCategory.fromMap(Map<String, dynamic> json) => RecentPostBlogCategory(
    name: json["name"],
    slug: json["slug"],
    pivot: json["pivot"] == null ? null : FluffyPivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "slug": slug,
    "pivot": pivot?.toMap(),
  };
}

class FluffyPivot {
  dynamic blogCategoryId;
  int? blogId;

  FluffyPivot({
    this.blogCategoryId,
    this.blogId,
  });

  factory FluffyPivot.fromJson(String str) => FluffyPivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FluffyPivot.fromMap(Map<String, dynamic> json) => FluffyPivot(
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

class Comment {
  int? id;
  String? name;
  String? email;
  String? message;
  int? blogId;
  int? parentId;
  int? order;
  int? isActive;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  List<Comment>? replies;

  Comment({
    this.id,
    this.name,
    this.email,
    this.message,
    this.blogId,
    this.parentId,
    this.order,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.replies,
  });

  factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    message: json["message"],
    blogId: json["blog_id"],
    parentId: json["parent_id"],
    order: json["order"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    replies: json["replies"] == null ? [] : List<Comment>.from(json["replies"]!.map((x) => Comment.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "message": message,
    "blog_id": blogId,
    "parent_id": parentId,
    "order": order,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x.toMap())),
  };
}
