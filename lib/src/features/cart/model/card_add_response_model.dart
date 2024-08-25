import 'dart:convert';

class AddToCartResponse {
  bool? result;
  String? message;
  String? cartQuantity;

  AddToCartResponse({
    this.result,
    this.message,
    this.cartQuantity,
  });

  factory AddToCartResponse.fromJson(String str) => AddToCartResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddToCartResponse.fromMap(Map<String, dynamic> json) => AddToCartResponse(
    result: json["result"],
    message: json["message"],
    cartQuantity: json["cart_quantity"],
  );

  Map<String, dynamic> toMap() => {
    "result": result,
    "message": message,
    "cart_quantity": cartQuantity,
  };
}