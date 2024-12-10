import 'dart:convert';

class GroupShoppingGroupsResponse {
  List<JustCreated>? popular;
  List<JustCreated>? justCreated;

  GroupShoppingGroupsResponse({
    this.popular,
    this.justCreated,
  });

  factory GroupShoppingGroupsResponse.fromJson(String str) => GroupShoppingGroupsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupShoppingGroupsResponse.fromMap(Map<String, dynamic> json) => GroupShoppingGroupsResponse(
    popular: json["popular"] == null ? [] : List<JustCreated>.from(json["popular"]!.map((x) => JustCreated.fromMap(x))),
    justCreated: json["just_created"] == null ? [] : List<JustCreated>.from(json["just_created"]!.map((x) => JustCreated.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "popular": popular == null ? [] : List<dynamic>.from(popular!.map((x) => x.toMap())),
    "just_created": justCreated == null ? [] : List<dynamic>.from(justCreated!.map((x) => x.toMap())),
  };
}

class JustCreated {
  int? id;
  String? title;
  int? groupPurchasePrice;
  Product? product;
  dynamic description;
  String? token;
  int? totalUserQuantity;
  int? currentUserQuantity;
  GroupAdmin? groupAdmin;
  DateTime? createdAt;
  DateTime? expiredAt;

  JustCreated({
    this.id,
    this.title,
    this.groupPurchasePrice,
    this.product,
    this.description,
    this.token,
    this.totalUserQuantity,
    this.currentUserQuantity,
    this.groupAdmin,
    this.createdAt,
    this.expiredAt,
  });

  factory JustCreated.fromJson(String str) => JustCreated.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JustCreated.fromMap(Map<String, dynamic> json) => JustCreated(
    id: json["id"],
    title: json["title"],
    groupPurchasePrice: json["group_purchase_price"],
    product: json["product"] == null ? null : Product.fromMap(json["product"]),
    description: json["description"],
    token: json["token"],
    totalUserQuantity: json["total_user_quantity"],
    currentUserQuantity: json["current_user_quantity"],
    groupAdmin: json["group_admin"] == null ? null : GroupAdmin.fromMap(json["group_admin"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    expiredAt: json["expired_at"] == null ? null : DateTime.parse(json["expired_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "group_purchase_price": groupPurchasePrice,
    "product": product?.toMap(),
    "description": description,
    "token": token,
    "total_user_quantity": totalUserQuantity,
    "current_user_quantity": currentUserQuantity,
    "group_admin": groupAdmin?.toMap(),
    "created_at": createdAt?.toIso8601String(),
    "expired_at": expiredAt?.toIso8601String(),
  };
}

class GroupAdmin {
  int? id;
  String? name;
  dynamic type;
  dynamic avatar;
  dynamic avatarOriginal;

  GroupAdmin({
    this.id,
    this.name,
    this.type,
    this.avatar,
    this.avatarOriginal,
  });

  factory GroupAdmin.fromJson(String str) => GroupAdmin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupAdmin.fromMap(Map<String, dynamic> json) => GroupAdmin(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    avatar: json["avatar"],
    avatarOriginal: json["avatar_original"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "type": type,
    "avatar": avatar,
    "avatar_original": avatarOriginal,
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
