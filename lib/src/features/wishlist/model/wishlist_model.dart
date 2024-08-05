class WishlistResponse {
  List<ProductData>? data;
  bool? success;
  int? status;

  WishlistResponse({this.data, this.success, this.status});

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => ProductData.fromJson(i)).toList()
          : null,
      success: json['success'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((v) => v.toJson()).toList(),
      'success': success,
      'status': status,
    };
  }
}

class ProductData {
  int? id;
  Product? product;

  ProductData({this.id, this.product});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
    };
  }
}

class Product {
  int? id;
  String? name;
  int? stock;
  int? preorderAvailable;
  String? thumbnailImage;
  String? basePrice;
  double? rating;

  Product({
    this.id,
    this.name,
    this.stock,
    this.preorderAvailable,
    this.thumbnailImage,
    this.basePrice,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
      preorderAvailable: json['preorder_available'],
      thumbnailImage: json['thumbnail_image'],
      basePrice: json['base_price'],
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stock': stock,
      'preorder_available': preorderAvailable,
      'thumbnail_image': thumbnailImage,
      'base_price': basePrice,
      'rating': rating,
    };
  }
}
