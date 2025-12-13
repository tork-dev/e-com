import 'dart:convert';

class SaleSpinnerCouponList {
  List<Datum>? data;
  bool? success;
  int? status;

  SaleSpinnerCouponList({
    this.data,
    this.success,
    this.status,
  });

  factory SaleSpinnerCouponList.fromJson(String str) => SaleSpinnerCouponList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaleSpinnerCouponList.fromMap(Map<String, dynamic> json) => SaleSpinnerCouponList(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "success": success,
    "status": status,
  };
}

class Datum {
  int? id;
  String? couponCode;
  String? discountType;
  int? discount;
  String? title;


  Datum({
    this.id,
    this.couponCode,
    this.discountType,
    this.discount,
    this.title
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    couponCode: json["coupon_code"],
    discountType: json["discount_type"],
    discount: json["discount"],
    title: json["title"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "coupon_code": couponCode,
    "discount_type": discountType,
    "discount": discount,
    "title": title
  };
}
