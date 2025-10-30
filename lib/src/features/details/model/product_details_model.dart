
import 'dart:convert';

import 'package:kirei/src/features/home/model/home_products_model.dart';

ProductDetailsResponse productDetailsResponseFromJson(String str) =>
    ProductDetailsResponse.fromJson(json.decode(str));


class ProductDetailsResponse {
  ProductDetailsResponse({
    this.detailedProducts,
    this.success,
    this.status,
  });

  Product? detailedProducts;
  bool? success;
  int? status;

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        detailedProducts: Product.fromJson(json["data"]),
        success: json["success"],
        status: json["status"],
      );

}
