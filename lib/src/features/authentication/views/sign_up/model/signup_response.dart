import 'dart:convert';

import 'package:flutter/material.dart';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  bool? result;
  String? accessToken;
  String? tokenType;
  User? user;
  String? message;
  int? userId;

  SignupResponse(
      {this.result,
        this.accessToken,
        this.tokenType,
        this.user,
        this.message,
        this.userId});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    message = json['message'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['message'] = this.message;
    data['user_id'] = this.userId;
    return data;
  }
}

class User {
  int? id;
  Null? referredBy;
  Null? providerId;
  String? userType;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? verificationCode;
  Null? newEmailVerificiationCode;
  Null? deviceToken;
  Null? avatar;
  Null? avatarOriginal;
  Null? address;
  Null? country;
  Null? state;
  Null? city;
  Null? cityId;
  Null? zoneId;
  Null? areaId;
  Null? postalCode;
  Null? phone;
  int? balance;
  int? banned;
  Null? referralCode;
  Null? customerPackageId;
  int? remainingUploads;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.referredBy,
        this.providerId,
        this.userType,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.verificationCode,
        this.newEmailVerificiationCode,
        this.deviceToken,
        this.avatar,
        this.avatarOriginal,
        this.address,
        this.country,
        this.state,
        this.city,
        this.cityId,
        this.zoneId,
        this.areaId,
        this.postalCode,
        this.phone,
        this.balance,
        this.banned,
        this.referralCode,
        this.customerPackageId,
        this.remainingUploads,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referredBy = json['referred_by'];
    providerId = json['provider_id'];
    userType = json['user_type'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    verificationCode = json['verification_code'];
    newEmailVerificiationCode = json['new_email_verificiation_code'];
    deviceToken = json['device_token'];
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    cityId = json['city_id'];
    zoneId = json['zone_id'];
    areaId = json['area_id'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    balance = json['balance'];
    banned = json['banned'];
    referralCode = json['referral_code'];
    customerPackageId = json['customer_package_id'];
    remainingUploads = json['remaining_uploads'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['referred_by'] = this.referredBy;
    data['provider_id'] = this.providerId;
    data['user_type'] = this.userType;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['verification_code'] = this.verificationCode;
    data['new_email_verificiation_code'] = this.newEmailVerificiationCode;
    data['device_token'] = this.deviceToken;
    data['avatar'] = this.avatar;
    data['avatar_original'] = this.avatarOriginal;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['city_id'] = this.cityId;
    data['zone_id'] = this.zoneId;
    data['area_id'] = this.areaId;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['balance'] = this.balance;
    data['banned'] = this.banned;
    data['referral_code'] = this.referralCode;
    data['customer_package_id'] = this.customerPackageId;
    data['remaining_uploads'] = this.remainingUploads;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}