import 'dart:convert';

class MyCouponListModel {
  List<CouponList>? data;
  bool? success;
  int? status;

  MyCouponListModel({
    this.data,
    this.success,
    this.status,
  });

  factory MyCouponListModel.fromJson(String str) => MyCouponListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyCouponListModel.fromMap(Map<String, dynamic> json) => MyCouponListModel(
    data: json["data"] == null ? [] : List<CouponList>.from(json["data"]!.map((x) => CouponList.fromMap(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "success": success,
    "status": status,
  };
}

class CouponList {
  int? id;
  String? couponCode;
  dynamic title;
  String? couponType;
  int? discount;
  String? couponEvent;
  bool? isUsed;
  String? expiredAt;
  String? createdAt;

  CouponList({
    this.id,
    this.couponCode,
    this.title,
    this.couponType,
    this.discount,
    this.couponEvent,
    this.isUsed,
    this.expiredAt,
    this.createdAt,
  });

  factory CouponList.fromJson(String str) => CouponList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CouponList.fromMap(Map<String, dynamic> json) => CouponList(
    id: json["id"],
    couponCode: json["coupon_code"],
    title: json["title"],
    couponType: json["coupon_type"],
    discount: json["discount"],
    couponEvent: json["coupon_event"],
    isUsed: json["is_used"],
    expiredAt: json["expired_at"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "coupon_code": couponCode,
    "title": title,
    "coupon_type": couponType,
    "discount": discount,
    "coupon_event": couponEvent,
    "is_used": isUsed,
    "expired_at": expiredAt,
    "created_at": createdAt,
  };
}
