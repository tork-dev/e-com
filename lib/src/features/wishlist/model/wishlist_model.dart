import 'package:kirei/src/features/home/model/home_products_model.dart';

class WishlistResponse {
  List<Product>? data;
  bool? success;
  int? status;

  WishlistResponse({this.data, this.success, this.status});

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Product.fromJson(i)).toList()
          : null,
      success: json['success'],
      status: json['status'],
    );
  }
}


