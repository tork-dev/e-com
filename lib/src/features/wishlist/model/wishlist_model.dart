
import 'package:kirei/src/features/home/model/home_products_model.dart';

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
}


