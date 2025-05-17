import 'dart:convert';
import 'dart:developer';  // Import for logging

class DetailsProductsResponse {
  bool? result;
  List<Datum>? data;
  String? message;

  DetailsProductsResponse({
    this.result,
    this.data,
    this.message,
  });

  factory DetailsProductsResponse.fromRawJson(String str) => DetailsProductsResponse.fromJson(json.decode(str));

  //String toRawJson() => json.encode(toJson());

  factory DetailsProductsResponse.fromJson(Map<String, dynamic> json) => DetailsProductsResponse(
    result: json["result"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  // Map<String, dynamic> toJson() => {
  //   "result": result,
  //   "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  //   "message": message,
  // };
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
  String? saleEndTime;

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
    this.saleEndTime
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  //String toRawJson() => json.encode(toJson());

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
    preorderDeliveryDate: preorderDeliveryDateValues.map[json["preorder_delivery_date"]],
    preorderAmount: json["preorder_amount"],
    preorderStartDate: preorderStartDateValues.map[json["preorder_start_date"]],
    preorderEndDate: preorderEndDateValues.map[json["preorder_end_date"]],
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
    saleEndTime: json["scheduled_price_end_date"],
  );

}

class GoodFor {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  GoodFor({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory GoodFor.fromRawJson(String str) => GoodFor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodFor.fromJson(Map<String, dynamic> json) => GoodFor(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  int? productId;
  int? tagId;
  dynamic goodForId;
  dynamic keyIngredientId;
  dynamic skinTypeId;

  Pivot({
    this.productId,
    this.tagId,
    this.goodForId,
    this.keyIngredientId,
    this.skinTypeId,
  });

  factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    productId: json["product_id"],
    tagId: json["tag_id"],
    goodForId: json["good_for_id"],
    keyIngredientId: json["key_ingredient_id"],
    skinTypeId: json["skin_type_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "tag_id": tagId,
    "good_for_id": goodForId,
    "key_ingredient_id": keyIngredientId,
    "skin_type_id": skinTypeId,
  };
}

class Picture {
  String? url;
  int? width;
  int? height;

  Picture({
    this.url,
    this.width,
    this.height,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}

class ProductBrand {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  ProductBrand({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory ProductBrand.fromRawJson(String str) => ProductBrand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductBrand.fromJson(Map<String, dynamic> json) => ProductBrand(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pivot": pivot?.toJson(),
  };
}

class ProductCategory {
  Name? name;
  Slug? slug;
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

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    Name? nameValue;
    Slug? slugValue;
    try {
      nameValue = nameValues.map[json["name"]];
    } catch (e) {
      log("Invalid name value: ${json["name"]}");
    }
    try {
      slugValue = slugValues.map[json["slug"]];
    } catch (e) {
      log("Invalid slug value: ${json["slug"]}");
    }
    return ProductCategory(
      name: nameValue,
      slug: slugValue,
      parentName: json["parent_name"],
      pivot: json["pivot"] == null ? null : ProductCategoryPivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "slug": slugValues.reverse[slug],
    "parent_name": parentName,
    "pivot": pivot?.toJson(),
  };
}

class ProductCategoryPivot {
  int? productId;
  int? categoryId;

  ProductCategoryPivot({
    this.productId,
    this.categoryId,
  });

  factory ProductCategoryPivot.fromRawJson(String str) => ProductCategoryPivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategoryPivot.fromJson(Map<String, dynamic> json) => ProductCategoryPivot(
    productId: json["product_id"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "category_id": categoryId,
  };
}

enum Name {
  SKIN_CARE,
  SUNSCREEN
}

final nameValues = EnumValues({
  "Skin Care": Name.SKIN_CARE,
  "Sunscreen": Name.SUNSCREEN
});

enum Slug {
  SKIN_CARE,
  SUNSCREEN
}

final slugValues = EnumValues({
  "skin-care": Slug.SKIN_CARE,
  "sunscreen": Slug.SUNSCREEN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

enum PreorderDeliveryDate {
  THE_2022_11_11_T00_00_00_000000_Z
}

final preorderDeliveryDateValues = EnumValues({
  "2022-11-11T00:00:00.000000Z": PreorderDeliveryDate.THE_2022_11_11_T00_00_00_000000_Z
});

enum PreorderEndDate {
  THE_2022_10_20_T00_00_00_000000_Z
}

final preorderEndDateValues = EnumValues({
  "2022-10-20T00:00:00.000000Z": PreorderEndDate.THE_2022_10_20_T00_00_00_000000_Z
});

enum PreorderStartDate {
  THE_2022_09_18_T00_00_00_000000_Z
}

final preorderStartDateValues = EnumValues({
  "2022-09-18T00:00:00.000000Z": PreorderStartDate.THE_2022_09_18_T00_00_00_000000_Z
});
