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
  int? stock;
  int? preorderAvailable;
  int? requestAvailable;
  int? preorderAmount;
  int? groupMemberQuantity;
  double? ratings;
  int? reviews;
  int? isHot;
  bool? isSale;
  int? isNew;
  dynamic isOutOfStock;
  List<Picture>? pictures;
  List<Picture>? largePictures;
  List<Picture>? smallPictures;
  int? isCouponApplicable;
  String? productLink;

  Product({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.salePrice,
    this.discount,
    this.stock,
    this.preorderAvailable,
    this.requestAvailable,
    this.preorderAmount,
    this.groupMemberQuantity,
    this.ratings,
    this.reviews,
    this.isHot,
    this.isSale,
    this.isNew,
    this.isOutOfStock,
    this.pictures,
    this.largePictures,
    this.smallPictures,
    this.isCouponApplicable,
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
    stock: json["stock"],
    preorderAvailable: json["preorder_available"],
    requestAvailable: json["request_available"],
    preorderAmount: json["preorder_amount"],
    groupMemberQuantity: json["group_member_quantity"],
    ratings: json["ratings"]?.toDouble(),
    reviews: json["reviews"],
    isHot: json["is_hot"],
    isSale: json["is_sale"],
    isNew: json["is_new"],
    isOutOfStock: json["is_out_of_stock"],
    pictures: json["pictures"] == null ? [] : List<Picture>.from(json["pictures"]!.map((x) => Picture.fromMap(x))),
    largePictures: json["large_pictures"] == null ? [] : List<Picture>.from(json["large_pictures"]!.map((x) => Picture.fromMap(x))),
    smallPictures: json["small_pictures"] == null ? [] : List<Picture>.from(json["small_pictures"]!.map((x) => Picture.fromMap(x))),
    isCouponApplicable: json["is_coupon_applicable"],
    productLink: json["product_link"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "slug": slug,
    "price": price,
    "sale_price": salePrice,
    "discount": discount,
    "stock": stock,
    "preorder_available": preorderAvailable,
    "request_available": requestAvailable,
    "preorder_amount": preorderAmount,
    "group_member_quantity": groupMemberQuantity,
    "ratings": ratings,
    "reviews": reviews,
    "is_hot": isHot,
    "is_sale": isSale,
    "is_new": isNew,
    "is_out_of_stock": isOutOfStock,
    "pictures": pictures == null ? [] : List<dynamic>.from(pictures!.map((x) => x.toMap())),
    "large_pictures": largePictures == null ? [] : List<dynamic>.from(largePictures!.map((x) => x.toMap())),
    "small_pictures": smallPictures == null ? [] : List<dynamic>.from(smallPictures!.map((x) => x.toMap())),
    "is_coupon_applicable": isCouponApplicable,
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

class HomepageSettings {
  GroupShopping? recommendation;
  GroupShopping? groupShopping;
  GroupShopping? kireitube;
  GroupShopping? surprizeGift;

  HomepageSettings({
    this.recommendation,
    this.groupShopping,
    this.kireitube,
    this.surprizeGift,
  });

  factory HomepageSettings.fromJson(String str) => HomepageSettings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomepageSettings.fromMap(Map<String, dynamic> json) => HomepageSettings(
    recommendation: json["recommendation"] == null ? null : GroupShopping.fromMap(json["recommendation"]),
    groupShopping: json["group_shopping"] == null ? null : GroupShopping.fromMap(json["group_shopping"]),
    kireitube: json["kireitube"] == null ? null : GroupShopping.fromMap(json["kireitube"]),
    surprizeGift: json["surprize_gift"] == null ? null : GroupShopping.fromMap(json["surprize_gift"]),
  );

  Map<String, dynamic> toMap() => {
    "recommendation": recommendation?.toMap(),
    "group_shopping": groupShopping?.toMap(),
    "kireitube": kireitube?.toMap(),
    "surprize_gift": surprizeGift?.toMap(),
  };
}

class GroupShopping {
  String? title;
  String? description;
  String? banner;
  String? btnName;
  String? isActive;
  String? route;

  GroupShopping({
    this.title,
    this.description,
    this.banner,
    this.btnName,
    this.isActive,
    this.route,
  });

  factory GroupShopping.fromJson(String str) => GroupShopping.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupShopping.fromMap(Map<String, dynamic> json) => GroupShopping(
    title: json["title"],
    description: json["description"],
    banner: json["banner"],
    btnName: json["btn_name"],
    isActive: json["is_active"],
    route: json["route"]
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "banner": banner,
    "btn_name": btnName,
    "is_active": isActive,
    "route" : route
  };
}

class Review {
  int? id;
  int? userId;
  String? userName;
  String? avatar;
  dynamic rating;
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
  String? title;
  String? slug;
  String? banner;

  SkinConcern({
    this.title,
    this.slug,
    this.banner
  });

  factory SkinConcern.fromJson(String str) => SkinConcern.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SkinConcern.fromMap(Map<String, dynamic> json) => SkinConcern(
    title: json["title"],
    slug: json["slug"],
    banner: json["banner"]
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "slug": slug,
    "banner" : banner,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
