import 'dart:convert';
import '../../home/model/home_products_model.dart';



class KireiTubeDetailsResponse {
  Data? data;
  bool? success;
  bool? result;
  dynamic status;

  KireiTubeDetailsResponse({
    this.data,
    this.success,
    this.result,
    this.status,
  });

  factory KireiTubeDetailsResponse.fromJson(String str) => KireiTubeDetailsResponse.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory KireiTubeDetailsResponse.fromMap(Map<String, dynamic> json) => KireiTubeDetailsResponse(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    success: json["success"],
    result: json["result"],
    status: json["status"],
  );

}

class Data {
  dynamic id;
  String? title;
  String? slug;
  String? categoryName;
  String? banner;
  String? shortDescription;
  String? description;
  String? video;
  String? orientation;
  Statistics? statistics;
  NextVideo? nextVideo;
  NextVideo? prevVideo;
  List<Product>? products;

  Data({
    this.id,
    this.title,
    this.slug,
    this.categoryName,
    this.banner,
    this.shortDescription,
    this.description,
    this.video,
    this.orientation,
    this.statistics,
    this.nextVideo,
    this.prevVideo,
    this.products,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    categoryName: json["category_name"],
    banner: json["banner"],
    shortDescription: json["short_description"],
    description: json["description"],
    video: json["video"],
    orientation: json["orientation"],
    statistics: json['statistics'] is Map<String, dynamic>
        ? Statistics.fromJson(json['statistics'] as Map<String, dynamic>)
        : null,
    nextVideo: json["next_video"] == null ? null : NextVideo.fromMap(json["next_video"]) ,
    prevVideo: json["prev_video"] == null ? null : NextVideo.fromMap(json["prev_video"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
  );

}

class NextVideo{
  String? title;
  String? slug;
  String? orientation;

  NextVideo({
    this.title,
    this.slug,
    this.orientation
});

  factory NextVideo.fromJson(String str) => NextVideo.fromMap(json.decode(str));

  factory NextVideo.fromMap(Map<String, dynamic> json) => NextVideo(

    title: json["title"],
    slug: json["slug"],
    orientation: json["orientation"]
  );

}


class Picture {
  String? url;
  dynamic width;
  dynamic height;
  LargePicturePivot? pivot;

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
    pivot: json["pivot"] == null ? null : LargePicturePivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "width": width,
    "height": height,
    "pivot": pivot?.toMap(),
  };
}

class LargePicturePivot {
  dynamic relatedId;
  String? uploadFileId;

  LargePicturePivot({
    this.relatedId,
    this.uploadFileId,
  });

  factory LargePicturePivot.fromJson(String str) => LargePicturePivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LargePicturePivot.fromMap(Map<String, dynamic> json) => LargePicturePivot(
    relatedId: json["related_id"],
    uploadFileId: json["upload_file_id"],
  );

  Map<String, dynamic> toMap() => {
    "related_id": relatedId,
    "upload_file_id": uploadFileId,
  };
}

class ProductBrand {
  String? name;
  String? slug;
  ProductBrandPivot? pivot;

  ProductBrand({
    this.name,
    this.slug,
    this.pivot,
  });

  factory ProductBrand.fromJson(String str) => ProductBrand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductBrand.fromMap(Map<String, dynamic> json) => ProductBrand(
    name: json["name"],
    slug: json["slug"],
    pivot: json["pivot"] == null ? null : ProductBrandPivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "slug": slug,
    "pivot": pivot?.toMap(),
  };
}

class ProductBrandPivot {
  dynamic productId;
  dynamic productBrandId;

  ProductBrandPivot({
    this.productId,
    this.productBrandId,
  });

  factory ProductBrandPivot.fromJson(String str) => ProductBrandPivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductBrandPivot.fromMap(Map<String, dynamic> json) => ProductBrandPivot(
    productId: json["product_id"],
    productBrandId: json["product_brand_id"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "product_brand_id": productBrandId,
  };
}

class ProductCategory {
  String? name;
  String? slug;
  dynamic parentName;
  ProductCategoryPivot? pivot;

  ProductCategory({
    this.name,
    this.slug,
    this.parentName,
    this.pivot,
  });

  factory ProductCategory.fromJson(String str) => ProductCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromMap(Map<String, dynamic> json) => ProductCategory(
    name: json["name"],
    slug: json["slug"],
    parentName: json["parent_name"],
    pivot: json["pivot"] == null ? null : ProductCategoryPivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "slug": slug,
    "parent_name": parentName,
    "pivot": pivot?.toMap(),
  };
}

class ProductCategoryPivot {
  dynamic productId;
  dynamic productCategoryId;

  ProductCategoryPivot({
    this.productId,
    this.productCategoryId,
  });

  factory ProductCategoryPivot.fromJson(String str) => ProductCategoryPivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductCategoryPivot.fromMap(Map<String, dynamic> json) => ProductCategoryPivot(
    productId: json["product_id"],
    productCategoryId: json["product_category_id"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "product_category_id": productCategoryId,
  };
}

class ProductTag {
  String? name;
  String? slug;
  ProductTagPivot? pivot;

  ProductTag({
    this.name,
    this.slug,
    this.pivot,
  });

  factory ProductTag.fromJson(String str) => ProductTag.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductTag.fromMap(Map<String, dynamic> json) => ProductTag(
    name: json["name"],
    slug: json["slug"],
    pivot: json["pivot"] == null ? null : ProductTagPivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "slug": slug,
    "pivot": pivot?.toMap(),
  };
}

class ProductTagPivot {
  dynamic productId;
  dynamic productTagId;

  ProductTagPivot({
    this.productId,
    this.productTagId,
  });

  factory ProductTagPivot.fromJson(String str) => ProductTagPivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductTagPivot.fromMap(Map<String, dynamic> json) => ProductTagPivot(
    productId: json["product_id"],
    productTagId: json["product_tag_id"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "product_tag_id": productTagId,
  };
}

class Statistics {
  final String? viewCount;
  final String? likeCount;
  final String? favoriteCount;
  final String? commentCount;

  Statistics({
    this.viewCount,
    this.likeCount,
    this.favoriteCount,
    this.commentCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      viewCount: json['viewCount'] as String?,
      likeCount: json['likeCount'] as String?,
      favoriteCount: json['favoriteCount'] as String?,
      commentCount: json['commentCount'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'viewCount': viewCount,
      'likeCount': likeCount,
      'favoriteCount': favoriteCount,
      'commentCount': commentCount,
    };
  }
}
