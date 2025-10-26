import 'dart:convert';

import 'package:kirei/src/features/home/model/home_products_model.dart';  // Import for logging

class DetailsProductsResponse {
  bool? result;
  List<Product>? data;
  String? message;

  DetailsProductsResponse({
    this.result,
    this.data,
    this.message,
  });

  factory DetailsProductsResponse.fromRawJson(String str) => DetailsProductsResponse.fromJson(json.decode(str));


  factory DetailsProductsResponse.fromJson(Map<String, dynamic> json) => DetailsProductsResponse(
    result: json["result"],
    data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
    message: json["message"],
  );
}
