import 'dart:convert';

class HomeProductResponse {
  List<Product>? newProducts;
  List<Product>? bestsellingProducts;
  List<Product>? featuredProducts;
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
    this.success,
    this.status,
    this.sliders,
    this.reviews,
    this.skinConcern,
    this.homepageSettings,
  });

  factory HomeProductResponse.fromJson(String str) => HomeProductResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomeProductResponse.fromMap(Map<String, dynamic> json) => HomeProductResponse(
    newProducts: json["new_products"] == null ? [] : List<Product>.from(json["new_products"]!.map((x) => Product.fromMap(x))),
    bestsellingProducts: json["bestselling_products"] == null ? [] : List<Product>.from(json["bestselling_products"]!.map((x) => Product.fromMap(x))),
    featuredProducts: json["featured_products"] == null ? [] : List<Product>.from(json["featured_products"]!.map((x) => Product.fromMap(x))),
    success: json["success"],
    status: json["status"],
    sliders: json["sliders"] == null ? [] : List<Slider>.from(json["sliders"]!.map((x) => Slider.fromMap(x))),
    reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromMap(x))),
    skinConcern: json["skin_concern"] == null ? [] : List<SkinConcern>.from(json["skin_concern"]!.map((x) => SkinConcern.fromMap(x))),
    homepageSettings: json["homepage_settings"] == null ? null : HomepageSettings.fromMap(json["homepage_settings"]),
  );

  Map<String, dynamic> toMap() => {
    "new_products": newProducts == null ? [] : List<dynamic>.from(newProducts!.map((x) => x.toMap())),
    "bestselling_products": bestsellingProducts == null ? [] : List<dynamic>.from(bestsellingProducts!.map((x) => x.toMap())),
    "featured_products": featuredProducts == null ? [] : List<dynamic>.from(featuredProducts!.map((x) => x.toMap())),
    "success": success,
    "status": status,
    "sliders": sliders == null ? [] : List<dynamic>.from(sliders!.map((x) => x.toMap())),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toMap())),
    "skin_concern": skinConcern == null ? [] : List<dynamic>.from(skinConcern!.map((x) => x.toMap())),
    "homepage_settings": homepageSettings?.toMap(),
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
    this.last30DaySaleCount,
    this.groupMemberQuantity,
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
    "skin_types": skinTypes == null ? [] : List<dynamic>.from(skinTypes!.map((x) => x.toMap())),
    "key_ingredients": keyIngredients == null ? [] : List<dynamic>.from(keyIngredients!.map((x) => x.toMap())),
    "good_for": goodFor == null ? [] : List<dynamic>.from(goodFor!.map((x) => x.toMap())),
    "preorder_available": preorderAvailable,
    "request_available": requestAvailable,
    "preorder_delivery_date": preorderDeliveryDate,
    "preorder_amount": preorderAmount,
    "preorder_start_date": preorderStartDate,
    "preorder_end_date": preorderEndDate,
    "sale_count": saleCount,
    "last_30_day_sale_count": last30DaySaleCount,
    "group_member_quantity": groupMemberQuantity,
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

  GroupShopping({
    this.title,
    this.description,
    this.banner,
    this.bannerWeb,
    this.btnName,
    this.route,
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
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "banner": banner,
    "banner_web": bannerWeb,
    "btn_name": btnName,
    "route": route,
  };
}

class SurprizeGift {
  String? title;
  String? description;
  dynamic banner;
  String? btnName;

  SurprizeGift({
    this.title,
    this.description,
    this.banner,
    this.btnName,
  });

  factory SurprizeGift.fromJson(String str) => SurprizeGift.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurprizeGift.fromMap(Map<String, dynamic> json) => SurprizeGift(
    title: json["title"],
    description: json["description"],
    banner: json["banner"],
    btnName: json["btn_name"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "banner": banner,
    "btn_name": btnName,
  };
}

class Review {
  int? id;
  dynamic userId;
  String? userName;
  dynamic avatar;
  int? rating;
  String? comment;
  List<String>? images;
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
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
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
  dynamic banner;

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
