import 'dart:convert';

class HomeProductResponse {
  List<Product>? newProducts;
  List<Product>? bestsellingProducts;
  List<Product>? featuredProducts;
  List<Product>? internationalBrands;
  List<dynamic>? trending;
  bool? success;
  int? status;
  List<Slider>? sliders;
  List<Review>? reviews;
  List<SkinConcern>? skinConcern;
  HomepageSettings? homepageSettings;

  HomeProductResponse({
    this.newProducts,
    this.bestsellingProducts,
    this.featuredProducts,
    this.internationalBrands,
    this.trending,
    this.success,
    this.status,
    this.sliders,
    this.reviews,
    this.skinConcern,
    this.homepageSettings,
  });

  factory HomeProductResponse.fromJson(String str) => HomeProductResponse.fromMap(json.decode(str));

  factory HomeProductResponse.fromMap(Map<String, dynamic> json) => HomeProductResponse(
    newProducts: json["new_products"] == null ? [] : List<Product>.from(json["new_products"]!.map((x) => Product.fromMap(x))),
    bestsellingProducts: json["bestselling_products"] == null ? [] : List<Product>.from(json["bestselling_products"]!.map((x) => Product.fromMap(x))),
    featuredProducts: json["featured_products"] == null ? [] : List<Product>.from(json["featured_products"]!.map((x) => Product.fromMap(x))),
    internationalBrands: json["international_brands"] == null ? [] : List<Product>.from(json["international_brands"]!.map((x) => Product.fromMap(x))),
    trending: json["trending"] == null ? [] : List<dynamic>.from(json["trending"]!.map((x) => x)),
    success: json["success"],
    status: json["status"],
    sliders: json["sliders"] == null ? [] : List<Slider>.from(json["sliders"]!.map((x) => Slider.fromMap(x))),
    reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromMap(x))),
    skinConcern: json["skin_concern"] == null ? [] : List<SkinConcern>.from(json["skin_concern"]!.map((x) => SkinConcern.fromMap(x))),
    homepageSettings: json["homepage_settings"] == null ? null : HomepageSettings.fromMap(json["homepage_settings"]),
  );
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
  dynamic maxQty;
  DateTime? scheduledPriceEndDate;
  String? shortDescription;
  String? description;
  String? guide;
  List<GoodFor>? skinTypes;
  List<GoodFor>? keyIngredients;
  List<GoodFor>? goodFor;
  int? preorderAvailable;
  int? requestAvailable;
  String? preorderDeliveryDate;
  int? preorderAmount;
  String? preorderStartDate;
  String? preorderEndDate;
  int? saleCount;
  int? last30DaySaleCount;
  int? groupMemberQuantity;
  int? groupPurchasePrice;
  int? groupDuration;
  dynamic groupToken;
  dynamic ratings;
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
  DateTime? flashSaleStartDate;
  DateTime? flashSaleEndDate;

  Product({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.salePrice,
    this.discount,
    this.sku,
    this.stock,
    this.maxQty,
    this.scheduledPriceEndDate,
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
    this.last30DaySaleCount,
    this.groupMemberQuantity,
    this.groupPurchasePrice,
    this.groupDuration,
    this.groupToken,
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
    this.flashSaleEndDate,
    this.flashSaleStartDate
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));


  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    price: json["price"],
    salePrice: json["sale_price"],
    discount: json["discount"],
    sku: json["sku"],
    stock: json["stock"],
    maxQty: json["max_qty"],
    scheduledPriceEndDate: json["scheduled_price_end_date"] == null ? null : DateTime.parse(json["scheduled_price_end_date"]),
    shortDescription: json["short_description"],
    description: json["description"],
    guide: json["guide"],
    skinTypes: json["skin_types"] == null ? [] : List<GoodFor>.from(json["skin_types"]!.map((x) => GoodFor.fromMap(x))),
    keyIngredients: json["key_ingredients"] == null ? [] : List<GoodFor>.from(json["key_ingredients"]!.map((x) => GoodFor.fromMap(x))),
    goodFor: json["good_for"] == null ? [] : List<GoodFor>.from(json["good_for"]!.map((x) => GoodFor.fromMap(x))),
    preorderAvailable: json["preorder_available"],
    requestAvailable: json["request_available"],
    preorderDeliveryDate: json["preorder_delivery_date"],
    preorderAmount: json["preorder_amount"],
    preorderStartDate: json["preorder_start_date"],
    preorderEndDate: json["preorder_end_date"],
    saleCount: json["sale_count"],
    last30DaySaleCount: json["last_30_day_sale_count"],
    groupMemberQuantity: json["group_member_quantity"],
    groupPurchasePrice: json["group_purchase_price"],
    groupDuration: json["group_duration"],
    groupToken: json["group_token"],
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
    productTags: json["product_tags"] == null ? [] : List<GoodFor>.from(json["product_tags"]!.map((x) => GoodFor.fromMap(x))),
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
    flashSaleStartDate: json["hot_deals_start_datetime"] == null ? null : DateTime.parse(json["hot_deals_start_datetime"]),
    flashSaleEndDate: json["hot_deals_end_datetime"] == null ? null : DateTime.parse(json["hot_deals_end_datetime"]),
  );
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

  factory GoodFor.fromJson(String str) => GoodFor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoodFor.fromMap(Map<String, dynamic> json) => GoodFor(
    name: json["name"],
    slug: json["slug"],
    pivot: json["pivot"] == null ? null : GoodForPivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "slug": slug,
    "pivot": pivot?.toMap(),
  };
}

class GoodForPivot {
  int? productId;
  int? productTagId;

  GoodForPivot({
    this.productId,
    this.productTagId,
  });

  factory GoodForPivot.fromJson(String str) => GoodForPivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoodForPivot.fromMap(Map<String, dynamic> json) => GoodForPivot(
    productId: json["product_id"],
    productTagId: json["product_tag_id"],
  );

  Map<String, dynamic> toMap() => {
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

class HomepageSettings {
  Features? features;
  GroupShopping? recommendation;
  GroupShopping? groupShopping;
  GroupShopping? kireitube;
  SurprizeGift? surprizeGift;

  HomepageSettings({
    this.features,
    this.recommendation,
    this.groupShopping,
    this.kireitube,
    this.surprizeGift,
  });

  factory HomepageSettings.fromJson(String str) => HomepageSettings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomepageSettings.fromMap(Map<String, dynamic> json) => HomepageSettings(
    features: json["features"] == null ? null : Features.fromMap(json["features"]),
    recommendation: json["recommendation"] == null ? null : GroupShopping.fromMap(json["recommendation"]),
    groupShopping: json["group_shopping"] == null ? null : GroupShopping.fromMap(json["group_shopping"]),
    kireitube: json["kireitube"] == null ? null : GroupShopping.fromMap(json["kireitube"]),
    surprizeGift: json["surprize_gift"] == null ? null : SurprizeGift.fromMap(json["surprize_gift"]),
  );

  Map<String, dynamic> toMap() => {
    "features": features?.toMap(),
    "recommendation": recommendation?.toMap(),
    "group_shopping": groupShopping?.toMap(),
    "kireitube": kireitube?.toMap(),
    "surprize_gift": surprizeGift?.toMap(),
  };
}

class Features {
  bool? recommendation;
  bool? groupShopping;
  bool? surprizeGift;
  bool? kireitube;
  bool? skinConcern;
  bool? reviews;

  Features({
    this.recommendation,
    this.groupShopping,
    this.surprizeGift,
    this.kireitube,
    this.skinConcern,
    this.reviews,
  });

  factory Features.fromJson(String str) => Features.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Features.fromMap(Map<String, dynamic> json) => Features(
    recommendation: json["recommendation"],
    groupShopping: json["group_shopping"],
    surprizeGift: json["surprize_gift"],
    kireitube: json["kireitube"],
    skinConcern: json["skin_concern"],
    reviews: json["reviews"],
  );

  Map<String, dynamic> toMap() => {
    "recommendation": recommendation,
    "group_shopping": groupShopping,
    "surprize_gift": surprizeGift,
    "kireitube": kireitube,
    "skin_concern": skinConcern,
    "reviews": reviews,
  };
}

class GroupShopping {
  String? title;
  String? description;
  String? banner;
  String? bannerWeb;
  String? btnName;
  String? route;
  String? isActive;

  GroupShopping({
    this.title,
    this.description,
    this.banner,
    this.bannerWeb,
    this.btnName,
    this.route,
    this.isActive,
  });

  factory GroupShopping.fromJson(String str) => GroupShopping.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupShopping.fromMap(Map<String, dynamic> json) => GroupShopping(
    title: json["title"],
    description: json["description"],
    banner: json["banner"],
    bannerWeb: json["banner_web"],
    btnName: json["btn_name"],
    route: json["route"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "banner": banner,
    "banner_web": bannerWeb,
    "btn_name": btnName,
    "route": route,
    "is_active": isActive,
  };
}

class SurprizeGift {
  String? title;
  String? description;
  dynamic banner;
  String? btnName;
  String? isActive;

  SurprizeGift({
    this.title,
    this.description,
    this.banner,
    this.btnName,
    this.isActive,
  });

  factory SurprizeGift.fromJson(String str) => SurprizeGift.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurprizeGift.fromMap(Map<String, dynamic> json) => SurprizeGift(
    title: json["title"],
    description: json["description"],
    banner: json["banner"],
    btnName: json["btn_name"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "banner": banner,
    "btn_name": btnName,
    "is_active": isActive,
  };
}

class Review {
  int? id;
  int? userId;
  String? userName;
  String? avatar;
  int? rating;
  String? comment;
  List<dynamic>? images;
  List<dynamic>? replies;
  String? time;

  Review({
    this.id,
    this.userId,
    this.userName,
    this.avatar,
    this.rating,
    this.comment,
    this.images,
    this.replies,
    this.time,
  });

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    id: json["id"],
    userId: json["user_id"],
    userName: json["user_name"],
    avatar: json["avatar"],
    rating: json["rating"],
    comment: json["comment"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    replies: json["replies"] == null ? [] : List<dynamic>.from(json["replies"]!.map((x) => x)),
    time: json["time"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "user_name": userName,
    "avatar": avatar,
    "rating": rating,
    "comment": comment,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x)),
    "time": time,
  };
}

class SkinConcern {
  int? id;
  String? title;
  String? slug;
  String? banner;

  SkinConcern({
    this.id,
    this.title,
    this.slug,
    this.banner,
  });

  factory SkinConcern.fromJson(String str) => SkinConcern.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SkinConcern.fromMap(Map<String, dynamic> json) => SkinConcern(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    banner: json["banner"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "banner": banner,
  };
}

class Slider {
  String? photo;
  String? link;

  Slider({
    this.photo,
    this.link,
  });

  factory Slider.fromJson(String str) => Slider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Slider.fromMap(Map<String, dynamic> json) => Slider(
    photo: json["photo"],
    link: json["link"],
  );

  Map<String, dynamic> toMap() => {
    "photo": photo,
    "link": link,
  };
}
