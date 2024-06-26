import 'dart:convert';

class SearchResponse {
  bool? result;
  List<Datum>? data;
  String? others;
  //Meta? meta;
  String? message;

  SearchResponse({
    this.result,
    this.data,
    this.others,
    //this.meta,
    this.message,
  });

  factory SearchResponse.fromRawJson(String str) => SearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    result: json["result"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    others: json["others"],
   // meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "others": others,
    //"meta": meta?.toJson(),
    "message": message,
  };
}

class Datum {
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
  List<GoodFor>? skinTypes;
  List<GoodFor>? keyIngredients;
  List<GoodFor>? goodFor;
  int? preorderAvailable;
  int? requestAvailable;
  PreorderDeliveryDate? preorderDeliveryDate;
  int? preorderAmount;
  PreorderStartDate? preorderStartDate;
  PreorderEndDate? preorderEndDate;
  int? saleCount;
  double? ratings;
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
  List<GoodFor>? productTags;
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

  Datum({
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

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    skinTypes: json["skin_types"] == null ? [] : List<GoodFor>.from(json["skin_types"]!.map((x) => GoodFor.fromJson(x))),
    keyIngredients: json["key_ingredients"] == null ? [] : List<GoodFor>.from(json["key_ingredients"]!.map((x) => GoodFor.fromJson(x))),
    goodFor: json["good_for"] == null ? [] : List<GoodFor>.from(json["good_for"]!.map((x) => GoodFor.fromJson(x))),
    preorderAvailable: json["preorder_available"],
    requestAvailable: json["request_available"],
    preorderDeliveryDate: preorderDeliveryDateValues.map[json["preorder_delivery_date"]]!,
    preorderAmount: json["preorder_amount"],
    preorderStartDate: preorderStartDateValues.map[json["preorder_start_date"]]!,
    preorderEndDate: preorderEndDateValues.map[json["preorder_end_date"]]!,
    saleCount: json["sale_count"],
    ratings: json["ratings"]?.toDouble(),
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
    productCategories: json["product_categories"] == null ? [] : List<ProductCategory>.from(json["product_categories"]!.map((x) => ProductCategory.fromJson(x))),
    productBrands: json["product_brands"] == null ? [] : List<ProductBrand>.from(json["product_brands"]!.map((x) => ProductBrand.fromJson(x))),
    productTags: json["product_tags"] == null ? [] : List<GoodFor>.from(json["product_tags"]!.map((x) => GoodFor.fromJson(x))),
    onlyTags: json["only_tags"],
    pictures: json["pictures"] == null ? [] : List<Picture>.from(json["pictures"]!.map((x) => Picture.fromJson(x))),
    largePictures: json["large_pictures"] == null ? [] : List<Picture>.from(json["large_pictures"]!.map((x) => Picture.fromJson(x))),
    smallPictures: json["small_pictures"] == null ? [] : List<Picture>.from(json["small_pictures"]!.map((x) => Picture.fromJson(x))),
    variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
    isCouponApplicable: json["is_coupon_applicable"],
    metaImage: json["meta_image"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaTags: json["meta_tags"],
    productLink: json["product_link"],
  );

  Map<String, dynamic> toJson() => {
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
    "skin_types": skinTypes == null ? [] : List<dynamic>.from(skinTypes!.map((x) => x.toJson())),
    "key_ingredients": keyIngredients == null ? [] : List<dynamic>.from(keyIngredients!.map((x) => x.toJson())),
    "good_for": goodFor == null ? [] : List<dynamic>.from(goodFor!.map((x) => x.toJson())),
    "preorder_available": preorderAvailable,
    "request_available": requestAvailable,
    "preorder_delivery_date": preorderDeliveryDateValues.reverse[preorderDeliveryDate],
    "preorder_amount": preorderAmount,
    "preorder_start_date": preorderStartDateValues.reverse[preorderStartDate],
    "preorder_end_date": preorderEndDateValues.reverse[preorderEndDate],
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
    "product_categories": productCategories == null ? [] : List<dynamic>.from(productCategories!.map((x) => x.toJson())),
    "product_brands": productBrands == null ? [] : List<dynamic>.from(productBrands!.map((x) => x.toJson())),
    "product_tags": productTags == null ? [] : List<dynamic>.from(productTags!.map((x) => x.toJson())),
    "only_tags": onlyTags,
    "pictures": pictures == null ? [] : List<dynamic>.from(pictures!.map((x) => x.toJson())),
    "large_pictures": largePictures == null ? [] : List<dynamic>.from(largePictures!.map((x) => x.toJson())),
    "small_pictures": smallPictures == null ? [] : List<dynamic>.from(smallPictures!.map((x) => x.toJson())),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
    "is_coupon_applicable": isCouponApplicable,
    "meta_image": metaImage,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_tags": metaTags,
    "product_link": productLink,
  };
}

class GoodFor {
  String? name;
  String? slug;
  GoodForPivot? pivot;

  GoodFor({
    this.name,
    this.slug,
    this.pivot,
  });

  factory GoodFor.fromRawJson(String str) => GoodFor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodFor.fromJson(Map<String, dynamic> json) => GoodFor(
    name: json["name"],
    slug: json["slug"],
    pivot: json["pivot"] == null ? null : GoodForPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "pivot": pivot?.toJson(),
  };
}

class GoodForPivot {
  int? productId;
  int? productTagId;

  GoodForPivot({
    this.productId,
    this.productTagId,
  });

  factory GoodForPivot.fromRawJson(String str) => GoodForPivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodForPivot.fromJson(Map<String, dynamic> json) => GoodForPivot(
    productId: json["product_id"],
    productTagId: json["product_tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_tag_id": productTagId,
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

  factory Picture.fromRawJson(String str) => Picture.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    url: json["url"],
    width: json["width"],
    height: json["height"],
    pivot: json["pivot"] == null ? null : LargePicturePivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
    "pivot": pivot?.toJson(),
  };
}

class LargePicturePivot {
  int? relatedId;
  String? uploadFileId;

  LargePicturePivot({
    this.relatedId,
    this.uploadFileId,
  });

  factory LargePicturePivot.fromRawJson(String str) => LargePicturePivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LargePicturePivot.fromJson(Map<String, dynamic> json) => LargePicturePivot(
    relatedId: json["related_id"],
    uploadFileId: json["upload_file_id"],
  );

  Map<String, dynamic> toJson() => {
    "related_id": relatedId,
    "upload_file_id": uploadFileId,
  };
}

enum PreorderDeliveryDate {
  THE_09052023,
  THE_30110001
}

final preorderDeliveryDateValues = EnumValues({
  "09-05-2023": PreorderDeliveryDate.THE_09052023,
  "30-11--0001": PreorderDeliveryDate.THE_30110001
});

enum PreorderEndDate {
  THE_25062024
}

final preorderEndDateValues = EnumValues({
  "25-06-2024": PreorderEndDate.THE_25062024
});

enum PreorderStartDate {
  THE_01011970,
  THE_30110001
}

final preorderStartDateValues = EnumValues({
  "01-01-1970": PreorderStartDate.THE_01011970,
  "30-11--0001": PreorderStartDate.THE_30110001
});

class ProductBrand {
  Name? name;
  Slug? slug;
  ProductBrandPivot? pivot;

  ProductBrand({
    this.name,
    this.slug,
    this.pivot,
  });

  factory ProductBrand.fromRawJson(String str) => ProductBrand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductBrand.fromJson(Map<String, dynamic> json) => ProductBrand(
    name: nameValues.map[json["name"]]!,
    slug: slugValues.map[json["slug"]]!,
    pivot: json["pivot"] == null ? null : ProductBrandPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "slug": slugValues.reverse[slug],
    "pivot": pivot?.toJson(),
  };
}

enum Name {
  DAISO,
  GRACLE
}

final nameValues = EnumValues({
  "Daiso": Name.DAISO,
  "gracle": Name.GRACLE
});

class ProductBrandPivot {
  int? productId;
  int? productBrandId;

  ProductBrandPivot({
    this.productId,
    this.productBrandId,
  });

  factory ProductBrandPivot.fromRawJson(String str) => ProductBrandPivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductBrandPivot.fromJson(Map<String, dynamic> json) => ProductBrandPivot(
    productId: json["product_id"],
    productBrandId: json["product_brand_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_brand_id": productBrandId,
  };
}

enum Slug {
  DAISO_LX_W7_D,
  GRACLE
}

final slugValues = EnumValues({
  "Daiso-lxW7D": Slug.DAISO_LX_W7_D,
  "gracle": Slug.GRACLE
});

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

  factory ProductCategory.fromRawJson(String str) => ProductCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    name: json["name"],
    slug: json["slug"],
    parentName: json["parent_name"],
    pivot: json["pivot"] == null ? null : ProductCategoryPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "parent_name": parentName,
    "pivot": pivot?.toJson(),
  };
}

class ProductCategoryPivot {
  int? productId;
  int? productCategoryId;

  ProductCategoryPivot({
    this.productId,
    this.productCategoryId,
  });

  factory ProductCategoryPivot.fromRawJson(String str) => ProductCategoryPivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategoryPivot.fromJson(Map<String, dynamic> json) => ProductCategoryPivot(
    productId: json["product_id"],
    productCategoryId: json["product_category_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_category_id": productCategoryId,
  };
}

class Meta {
  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  dynamic links;
  dynamic path;
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
    links: json["links"] == null ? [] : List<String>.from(json["links"]!.map((x) => x)),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x)),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
