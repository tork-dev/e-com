import 'dart:convert';

class ReOrderResponse {
  bool? result;
  String? message;
  Data? data;
  int? code;

  ReOrderResponse({
    this.result,
    this.message,
    this.data,
    this.code,
  });

  factory ReOrderResponse.fromRawJson(String str) => ReOrderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReOrderResponse.fromJson(Map<String, dynamic> json) => ReOrderResponse(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class Data {
  int? cartQuantity;

  Data({
    this.cartQuantity,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cartQuantity: json["cart_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "cart_quantity": cartQuantity,
  };
}
