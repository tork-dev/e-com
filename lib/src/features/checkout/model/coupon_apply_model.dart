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
      data: _parseData(json['data']),
      amount: json['amount']?.toDouble(),
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

  static Data? _parseData(dynamic json) {
    if (json == null || json == '') {
      return null; // Handle case where data is null or empty string
    } else if (json is Map<String, dynamic>) {
      return Data.fromJson(json);
    } else {
      throw Exception('Invalid data format for Data');
    }
  }
}

class Data {
  int? id;
  int? userId;
  String? type;
  String? code;
  Details? details;
  String? description;
  dynamic discount;
  String? discountType;
  int? isActive;
  int? isUnlimited;
  int? startDate;
  int? endDate;
  dynamic createdAt;
  dynamic updatedAt;
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
      details: json['details'] != null && json['details'] != '' ? Details.fromJson(jsonDecode(json['details'])) : null,
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
  dynamic minBuy;
  dynamic maxDiscount;

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
