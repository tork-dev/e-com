import 'dart:convert';

// Function to decode JSON string to Dart object
ProductMiniResponse productMiniResponseFromJson(String str, {String key = "data"}) =>
    ProductMiniResponse.fromJson(json.decode(str), key: key);

// Function to encode Dart object to JSON string
String productMiniResponseToJson(ProductMiniResponse data) =>
    json.encode(data.toJson());

// Main response class
class ProductMiniResponse {
  ProductMiniResponse({
    this.products,
    this.meta,
    this.success,
    this.status,
    this.message,
  });

  List<Product>? products;
  bool? success;
  int? status;
  Meta? meta;
  String? message;

  factory ProductMiniResponse.fromJson(Map<String, dynamic> json, {String key = "data"}) {
    List<Product> productsList = json[key] != null
        ? List<Product>.from(json[key].map((x) => Product.fromJson(x)))
        : [];

    return ProductMiniResponse(
      products: productsList,
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      success: json["result"], // Adjusted to match the example response
      status: json["status"] ?? 200, // Provide a default value for status
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": products != null
        ? List<dynamic>.from(products!.map((x) => x.toJson()))
        : [],
    "meta": meta?.toJson(),
    "success": success,
    "status": status,
    "message": message,
  };
}

// Product class
class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.salePrice,
    this.ratings,
    this.slug,
    this.reviews,
    this.stock,
    this.preorderAvailable,
    this.requestAvailable,
    this.discount,
    this.productCategories,
    this.pictures,
  });

  int? id;
  String? name;
  int? price;
  int? salePrice;
  dynamic ratings;
  String? slug;
  int? reviews;
  int? stock;
  int? preorderAvailable;
  int? requestAvailable;
  int? discount;
  List<ProductCategory>? productCategories;
  List<Picture>? pictures;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    salePrice: json["sale_price"],
    stock: json["stock"],
    ratings: json["ratings"],
    reviews: json["reviews"],
    productCategories: json["product_categories"] != null
        ? List<ProductCategory>.from(
        json["product_categories"].map((x) => ProductCategory.fromJson(x)))
        : [],
    pictures: json["pictures"] != null
        ? List<Picture>.from(json["pictures"].map((x) => Picture.fromJson(x)))
        : [],
    slug: json["slug"],
    discount: json["discount"],
    preorderAvailable: json["preorder_available"],
    requestAvailable: json["request_available"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "sale_price": salePrice,
    "stock": stock,
    "ratings": ratings,
    "reviews": reviews,
    "slug": slug,
    "discount": discount,
    "product_categories": productCategories != null
        ? List<dynamic>.from(productCategories!.map((x) => x.toJson()))
        : [],
    "pictures": pictures != null
        ? List<dynamic>.from(pictures!.map((x) => x.toJson()))
        : [],
    "preorder_available": preorderAvailable,
    "request_available": requestAvailable,
  };
}

// ProductCategory class
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

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    name: json["name"],
    slug: json["slug"],
    parentName: json["parent_name"],
    pivot: json["pivot"] != null ? Pivot.fromJson(json["pivot"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "parent_name": parentName,
    "pivot": pivot?.toJson(),
  };
}

// Picture class
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
    pivot: json["pivot"] != null ? Pivot.fromJson(json["pivot"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
    "pivot": pivot?.toJson(),
  };
}

// Pivot class
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

// Meta class
class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
    this.links,
  });

  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;
  dynamic links;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
    links: json["links"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
    "links": links,
  };
}
