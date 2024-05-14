import 'dart:convert';

// To parse this JSON data, do
//
//     final shopResponse = shopResponseFromJson(jsonString);

ShopPageResponse shopResponseFromJson(String str) =>
    ShopPageResponse.fromJson(json.decode(str));

String shopResponseToJson(ShopPageResponse data) => json.encode(data.toJson());

class ShopPageResponse {
  ShopPageResponse({
    this.result,
    this.data,
    this.others,
    this.meta,
    this.message,
  });

  bool? result;
  List<Data>? data;
  String? others;
  Meta? meta;
  String? message;

  factory ShopPageResponse.fromJson(Map<String, dynamic> json) => ShopPageResponse(
    result: json["result"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    others: json["others"],
    meta: Meta.fromJson(json["meta"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "others": others,
    "meta": meta!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
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
  List<SkinType>? skinTypes;
  List<KeyIngredient>? keyIngredients;
  List<GoodFor>? goodFor;
  int? preorderAvailable;
  String? preorderDeliveryDate;
  dynamic preorderAmount;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    skinTypes: List<SkinType>.from(
        json["skin_types"].map((x) => SkinType.fromJson(x))),
    keyIngredients: List<KeyIngredient>.from(
        json["key_ingredients"].map((x) => KeyIngredient.fromJson(x))),
    goodFor: List<GoodFor>.from(
        json["good_for"].map((x) => GoodFor.fromJson(x))),
    preorderAvailable: json["preorder_available"],
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
    productCategories: List<ProductCategory>.from(
        json["product_categories"].map((x) => ProductCategory.fromJson(x))),
    productBrands: List<ProductBrand>.from(
        json["product_brands"].map((x) => ProductBrand.fromJson(x))),
    productTags: List<ProductTag>.from(
        json["product_tags"].map((x) => ProductTag.fromJson(x))),
    onlyTags: json["only_tags"],
    pictures: List<Picture>.from(
        json["pictures"].map((x) => Picture.fromJson(x))),
    largePictures: List<Picture>.from(
        json["large_pictures"].map((x) => Picture.fromJson(x))),
    smallPictures: List<Picture>.from(
        json["small_pictures"].map((x) => Picture.fromJson(x))),
    variants: List<dynamic>.from(json["variants"].map((x) => x)),
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
    "skin_types": List<dynamic>.from(skinTypes!.map((x) => x.toJson())),
    "key_ingredients":
    List<dynamic>.from(keyIngredients!.map((x) => x.toJson())),
    "good_for": List<dynamic>.from(goodFor!.map((x) => x.toJson())),
    "preorder_available": preorderAvailable,
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
    "product_categories":
    List<dynamic>.from(productCategories!.map((x) => x.toJson())),
    "product_brands":
    List<dynamic>.from(productBrands!.map((x) => x.toJson())),
    "product_tags": List<dynamic>.from(productTags!.map((x) => x.toJson())),
    "only_tags": onlyTags,
    "pictures": List<dynamic>.from(pictures!.map((x) => x.toJson())),
    "large_pictures":
    List<dynamic>.from(largePictures!.map((x) => x.toJson())),
    "small_pictures":
    List<dynamic>.from(smallPictures!.map((x) => x.toJson())),
    "variants": List<dynamic>.from(variants!.map((x) => x)),
    "is_coupon_applicable": isCouponApplicable,
    "meta_image": metaImage,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_tags": metaTags,
    "product_link": productLink,
  };
}

class GoodFor {
  GoodFor({
    this.name,
    this.slug,
    this.pivot,
  });

  String? name;
  String? slug;
  Pivot? pivot;

  factory GoodFor.fromJson(Map<String, dynamic> json) => GoodFor(
    name: json["name"],
    slug: json["slug"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "pivot": pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    this.productId,
    this.productTagId,
  });

  int? productId;
  int? productTagId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    productId: json["product_id"],
    productTagId: json["product_tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_tag_id": productTagId,
  };
}

class KeyIngredient {
  KeyIngredient({
    this.name,
    this.slug,
    this.pivot,
  });

  String? name;
  String? slug;
  Pivot? pivot;

  factory KeyIngredient.fromJson(Map<String, dynamic> json) => KeyIngredient(
    name: json["name"],
    slug: json["slug"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "pivot": pivot!.toJson(),
  };
}

class Picture {
  Picture({
    this.url,
    this.width,
    this.height,
    this.pivot,
  });

  String? url;
  int? width;
  int? height;
  Pivot? pivot;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    url: json["url"],
    width: json["width"],
    height: json["height"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
    "pivot": pivot!.toJson(),
  };
}

class ProductBrand {
  ProductBrand({
    this.name,
    this.slug,
    this.pivot,
  });

  String? name;
  String? slug;
  Pivot? pivot;

  factory ProductBrand.fromJson(Map<String, dynamic> json) => ProductBrand(
    name: json["name"],
    slug: json["slug"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "pivot": pivot!.toJson(),
  };
}

class ProductCategory {
  ProductCategory({
    this.name,
    this.slug,
    this.parentName,
    this.pivot,
  });

  String? name;
  String? slug;
  dynamic parentName;
  Pivot? pivot;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        name: json["name"],
        slug: json["slug"],
        parentName: json["parent_name"],
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "parent_name": parentName,
    "pivot": pivot!.toJson(),
  };
}

class ProductTag {
  ProductTag({
    this.name,
    this.slug,
    this.pivot,
  });

  String? name;
  String? slug;
  Pivot? pivot;

  factory ProductTag.fromJson(Map<String, dynamic> json) => ProductTag(
    name: json["name"],
    slug: json["slug"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "pivot": pivot!.toJson(),
  };
}

class SkinType {
  SkinType({
    this.name,
    this.slug,
    this.pivot,
  });

  String? name;
  String? slug;
  Pivot? pivot;

  factory SkinType.fromJson(Map<String, dynamic> json) => SkinType(
    name: json["name"],
    slug: json["slug"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "pivot": pivot!.toJson(),
  };
}

class Meta {
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

  int? currentPage;
  int? from;
  int? lastPage;
  List<String>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<String>.from(json["links"].map((x) => x)),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links!.map((x) => x)),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}
