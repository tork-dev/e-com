import 'dart:convert';

class KireiTubeDetailsResponse {
  Data? data;
  bool? success;
  bool? result;
  int? status;

  KireiTubeDetailsResponse({
    this.data,
    this.success,
    this.result,
    this.status,
  });

  factory KireiTubeDetailsResponse.fromJson(String str) => KireiTubeDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KireiTubeDetailsResponse.fromMap(Map<String, dynamic> json) => KireiTubeDetailsResponse(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    success: json["success"],
    result: json["result"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
    "success": success,
    "result": result,
    "status": status,
  };
}

class Data {
  int? id;
  String? title;
  String? slug;
  String? categoryName;
  String? banner;
  String? shortDescription;
  String? description;
  String? video;
  Statistics? statistics;
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
    this.statistics,
    this.products,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    categoryName: json["category_name"],
    banner: json["banner"],
    shortDescription: json["short_description"],
    description: json["description"],
    video: json["video"],
    statistics: json["statistics"] == null ? null : Statistics.fromMap(json["statistics"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "category_name": categoryName,
    "banner": banner,
    "short_description": shortDescription,
    "description": description,
    "video": video,
    "statistics": statistics?.toMap(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toMap())),
  };
}

class Product {
  int? id;
  String? name;
  String? slug;
  int? price;
  int? salePrice;
  int? discount;
  String? sku;
  int? stock;
  String? shortDescription;
  String? description;
  String? guide;
  List<dynamic>? skinTypes;
  List<dynamic>? keyIngredients;
  List<dynamic>? goodFor;
  int? preorderAvailable;
  int? requestAvailable;
  String? preorderDeliveryDate;
  int? preorderAmount;
  String? preorderStartDate;
  String? preorderEndDate;
  int? saleCount;
  int? ratings;
  int? reviews;
  int? isHot;
  bool? isSale;
  int? isNew;
  dynamic isOutOfStock;
  dynamic releaseDate;
  dynamic developer;
  dynamic publisher;
  dynamic gameMode;
  dynamic rated;
  dynamic until;
  List<ProductCategory>? productCategories;
  List<ProductBrand>? productBrands;
  List<ProductTag>? productTags;
  String? onlyTags;
  List<Picture>? pictures;
  List<Picture>? largePictures;
  List<Picture>? smallPictures;
  List<dynamic>? variants;
  int? isCouponApplicable;
  String? metaImage;
  String? metaTitle;
  String? metaDescription;
  String? metaTags;
  String? productLink;

  Product({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.salePrice,
    this.discount,
    this.sku,
    this.stock,
    this.shortDescription,
    this.description,
    this.guide,
    this.skinTypes,
    this.keyIngredients,
    this.goodFor,
    this.preorderAvailable,
    this.requestAvailable,
    this.preorderDeliveryDate,
    this.preorderAmount,
    this.preorderStartDate,
    this.preorderEndDate,
    this.saleCount,
    this.ratings,
    this.reviews,
    this.isHot,
    this.isSale,
    this.isNew,
    this.isOutOfStock,
    this.releaseDate,
    this.developer,
    this.publisher,
    this.gameMode,
    this.rated,
    this.until,
    this.productCategories,
    this.productBrands,
    this.productTags,
    this.onlyTags,
    this.pictures,
    this.largePictures,
    this.smallPictures,
    this.variants,
    this.isCouponApplicable,
    this.metaImage,
    this.metaTitle,
    this.metaDescription,
    this.metaTags,
    this.productLink,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    price: json["price"],
    salePrice: json["sale_price"],
    discount: json["discount"],
    sku: json["sku"],
    stock: json["stock"],
    shortDescription: json["short_description"],
    description: json["description"],
    guide: json["guide"],
    skinTypes: json["skin_types"] == null ? [] : List<dynamic>.from(json["skin_types"]!.map((x) => x)),
    keyIngredients: json["key_ingredients"] == null ? [] : List<dynamic>.from(json["key_ingredients"]!.map((x) => x)),
    goodFor: json["good_for"] == null ? [] : List<dynamic>.from(json["good_for"]!.map((x) => x)),
    preorderAvailable: json["preorder_available"],
    requestAvailable: json["request_available"],
    preorderDeliveryDate: json["preorder_delivery_date"],
    preorderAmount: json["preorder_amount"],
    preorderStartDate: json["preorder_start_date"],
    preorderEndDate: json["preorder_end_date"],
    saleCount: json["sale_count"],
    ratings: json["ratings"],
    reviews: json["reviews"],
    isHot: json["is_hot"],
    isSale: json["is_sale"],
    isNew: json["is_new"],
    isOutOfStock: json["is_out_of_stock"],
    releaseDate: json["release_date"],
    developer: json["developer"],
    publisher: json["publisher"],
    gameMode: json["game_mode"],
    rated: json["rated"],
    until: json["until"],
    productCategories: json["product_categories"] == null ? [] : List<ProductCategory>.from(json["product_categories"]!.map((x) => ProductCategory.fromMap(x))),
    productBrands: json["product_brands"] == null ? [] : List<ProductBrand>.from(json["product_brands"]!.map((x) => ProductBrand.fromMap(x))),
    productTags: json["product_tags"] == null ? [] : List<ProductTag>.from(json["product_tags"]!.map((x) => ProductTag.fromMap(x))),
    onlyTags: json["only_tags"],
    pictures: json["pictures"] == null ? [] : List<Picture>.from(json["pictures"]!.map((x) => Picture.fromMap(x))),
    largePictures: json["large_pictures"] == null ? [] : List<Picture>.from(json["large_pictures"]!.map((x) => Picture.fromMap(x))),
    smallPictures: json["small_pictures"] == null ? [] : List<Picture>.from(json["small_pictures"]!.map((x) => Picture.fromMap(x))),
    variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
    isCouponApplicable: json["is_coupon_applicable"],
    metaImage: json["meta_image"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaTags: json["meta_tags"],
    productLink: json["product_link"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "slug": slug,
    "price": price,
    "sale_price": salePrice,
    "discount": discount,
    "sku": sku,
    "stock": stock,
    "short_description": shortDescription,
    "description": description,
    "guide": guide,
    "skin_types": skinTypes == null ? [] : List<dynamic>.from(skinTypes!.map((x) => x)),
    "key_ingredients": keyIngredients == null ? [] : List<dynamic>.from(keyIngredients!.map((x) => x)),
    "good_for": goodFor == null ? [] : List<dynamic>.from(goodFor!.map((x) => x)),
    "preorder_available": preorderAvailable,
    "request_available": requestAvailable,
    "preorder_delivery_date": preorderDeliveryDate,
    "preorder_amount": preorderAmount,
    "preorder_start_date": preorderStartDate,
    "preorder_end_date": preorderEndDate,
    "sale_count": saleCount,
    "ratings": ratings,
    "reviews": reviews,
    "is_hot": isHot,
    "is_sale": isSale,
    "is_new": isNew,
    "is_out_of_stock": isOutOfStock,
    "release_date": releaseDate,
    "developer": developer,
    "publisher": publisher,
    "game_mode": gameMode,
    "rated": rated,
    "until": until,
    "product_categories": productCategories == null ? [] : List<dynamic>.from(productCategories!.map((x) => x.toMap())),
    "product_brands": productBrands == null ? [] : List<dynamic>.from(productBrands!.map((x) => x.toMap())),
    "product_tags": productTags == null ? [] : List<dynamic>.from(productTags!.map((x) => x.toMap())),
    "only_tags": onlyTags,
    "pictures": pictures == null ? [] : List<dynamic>.from(pictures!.map((x) => x.toMap())),
    "large_pictures": largePictures == null ? [] : List<dynamic>.from(largePictures!.map((x) => x.toMap())),
    "small_pictures": smallPictures == null ? [] : List<dynamic>.from(smallPictures!.map((x) => x.toMap())),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
    "is_coupon_applicable": isCouponApplicable,
    "meta_image": metaImage,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_tags": metaTags,
    "product_link": productLink,
  };
}

class Picture {
  String? url;
  int? width;
  int? height;
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
  int? relatedId;
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
  int? productId;
  int? productBrandId;

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
  int? parentName;
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
  int? productId;
  int? productCategoryId;

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
  int? productId;
  int? productTagId;

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
  String? viewCount;
  String? likeCount;
  String? favoriteCount;
  String? commentCount;

  Statistics({
    this.viewCount,
    this.likeCount,
    this.favoriteCount,
    this.commentCount,
  });

  factory Statistics.fromJson(String str) => Statistics.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Statistics.fromMap(Map<String, dynamic> json) => Statistics(
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
