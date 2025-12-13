import 'dart:convert';

class SaleSpinnerCouponResponse {
  bool? result;
  String? message;
  Data? data;

  SaleSpinnerCouponResponse({
    this.result,
    this.message,
    this.data,
  });

  factory SaleSpinnerCouponResponse.fromJson(String str) => SaleSpinnerCouponResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaleSpinnerCouponResponse.fromMap(Map<String, dynamic> json) => SaleSpinnerCouponResponse(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "result": result,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  String? couponCode;
  dynamic image;
  String? title;
  String? description;
  String? expireAt;
  String? expiredMessage;

  Data({
    this.couponCode,
    this.image,
    this.title,
    this.description,
    this.expireAt,
    this.expiredMessage
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    couponCode: json["coupon_code"],
    image: json["image"],
    title: json["title"],
    description: json["description"],
    expireAt: json["expired_at"],
    expiredMessage: json["expired_message"]
  );

  Map<String, dynamic> toMap() => {
    "coupon_code": couponCode,
    "image": image,
    "title": title,
    "description": description,
  };
}
