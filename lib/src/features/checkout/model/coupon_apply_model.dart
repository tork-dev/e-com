import 'dart:convert';

class CouponResponse {
  bool? result;
  Data? data;
  double? amount;
  String? message;

  CouponResponse({
    this.result,
    this.data,
    this.amount,
    this.message,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      result: json['result'],
      data: Data.fromJson(json['data']),
      amount: json['amount'].toDouble(),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'data': data?.toJson(),
      'amount': amount,
      'message': message,
    };
  }
}

class Data {
  int? id;
  int? userId;
  String? type;
  String? code;
  Details? details;
  String? description;
  double? discount;
  String? discountType;
  int? isActive;
  int? isUnlimited;
  int? startDate;
  int? endDate;
  String? createdAt;
  String? updatedAt;
  double? totalDiscount;

  Data({
    this.id,
    this.userId,
    this.type,
    this.code,
    this.details,
    this.description,
    this.discount,
    this.discountType,
    this.isActive,
    this.isUnlimited,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.totalDiscount,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      code: json['code'],
      details: Details.fromJson(jsonDecode(json['details'])),
      description: json['description'],
      discount: json['discount'].toDouble(),
      discountType: json['discount_type'],
      isActive: json['is_active'],
      isUnlimited: json['is_unlimited'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      totalDiscount: json['total_discount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'code': code,
      'details': details?.toJson(),
      'description': description,
      'discount': discount,
      'discount_type': discountType,
      'is_active': isActive,
      'is_unlimited': isUnlimited,
      'start_date': startDate,
      'end_date': endDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'total_discount': totalDiscount,
    };
  }
}

class Details {
  int? minBuy;
  int? maxDiscount;

  Details({
    this.minBuy,
    this.maxDiscount,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      minBuy: json['min_buy'],
      maxDiscount: json['max_discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min_buy': minBuy,
      'max_discount': maxDiscount,
    };
  }
}