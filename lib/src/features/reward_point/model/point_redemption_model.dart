import 'dart:convert';

class PointRedemptionResponse {
  List<Datum>? data;
  bool? result;
  int? status;

  PointRedemptionResponse({
    this.data,
    this.result,
    this.status,
  });

  factory PointRedemptionResponse.fromJson(String str) => PointRedemptionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointRedemptionResponse.fromMap(Map<String, dynamic> json) => PointRedemptionResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    result: json["result"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "result": result,
    "status": status,
  };
}

class Datum {
  int? id;
  int? membershipId;
  String? membershipTitle;
  int? membershipMinRewardPoint;
  int? purchasePoint;
  Product? product;
  int? isUnlocked;
  int? needBalance;
  int? needEarnToUnlock;

  Datum({
    this.id,
    this.membershipId,
    this.membershipTitle,
    this.membershipMinRewardPoint,
    this.purchasePoint,
    this.product,
    this.isUnlocked,
    this.needBalance,
    this.needEarnToUnlock,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    membershipId: json["membership_id"],
    membershipTitle: json["membership_title"],
    membershipMinRewardPoint: json["membership_min_reward_point"],
    purchasePoint: json["purchase_point"],
    product: json["product"] == null ? null : Product.fromMap(json["product"]),
    isUnlocked: json["is_unlocked"],
    needBalance: json["need_balance"],
    needEarnToUnlock: json["need_earn_to_unlock"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "membership_id": membershipId,
    "membership_title": membershipTitle,
    "membership_min_reward_point": membershipMinRewardPoint,
    "purchase_point": purchasePoint,
    "product": product?.toMap(),
    "is_unlocked": isUnlocked,
    "need_balance": needBalance,
    "need_earn_to_unlock": needEarnToUnlock,
  };
}

class Product {
  int? id;
  String? name;
  String? slug;
  int? price;
  int? salePrice;
  String? thumbnailImage;
  int? stock;
  int? rating;
  int? sales;
  List<ProductCategory>? productCategories;

  Product({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.salePrice,
    this.thumbnailImage,
    this.stock,
    this.rating,
    this.sales,
    this.productCategories,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    price: json["price"],
    salePrice: json["sale_price"],
    thumbnailImage: json["thumbnail_image"],
    stock: json["stock"],
    rating: json["rating"],
    sales: json["sales"],
    productCategories: json["product_categories"] == null ? [] : List<ProductCategory>.from(json["product_categories"]!.map((x) => ProductCategory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "slug": slug,
    "price": price,
    "sale_price": salePrice,
    "thumbnail_image": thumbnailImage,
    "stock": stock,
    "rating": rating,
    "sales": sales,
    "product_categories": productCategories == null ? [] : List<dynamic>.from(productCategories!.map((x) => x.toMap())),
  };
}

class ProductCategory {
  String? name;
  String? slug;
  int? parentName;
  Pivot? pivot;

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
    pivot: json["pivot"] == null ? null : Pivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "slug": slug,
    "parent_name": parentName,
    "pivot": pivot?.toMap(),
  };
}

class Pivot {
  int? productId;
  int? productCategoryId;

  Pivot({
    this.productId,
    this.productCategoryId,
  });

  factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
    productId: json["product_id"],
    productCategoryId: json["product_category_id"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "product_category_id": productCategoryId,
  };
}
