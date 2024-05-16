import 'dart:convert';

import 'package:flutter/material.dart';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

SignupResendOtpResponse signupResendOtpResponseFromJson(String str) =>
    SignupResendOtpResponse.fromJson(json.decode(str));

String signupResendOtpResponseToJson(SignupResponse data) => json.encode(data.toJson());


class SignupResponse {
  bool? result;
  String? message;
  String? accessToken;
  String? tokenType;
  Null? expiresAt;
  User? user;
  String? phone;

  SignupResponse(
      {this.result,
        this.message,
        this.accessToken,
        this.tokenType,
        this.expiresAt,
        this.user,
        this.phone,
      });

  SignupResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    phone = json["phone"];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    data['phone'] = this.phone;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  Null? type;
  String? name;
  String? email;
  String? avatar;
  Null? avatarOriginal;
  Null? phone;
  bool? passwordSaved;

  User(
      {this.id,
        this.type,
        this.name,
        this.email,
        this.avatar,
        this.avatarOriginal,
        this.phone,
        this.passwordSaved});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    phone = json['phone'];
    passwordSaved = json['password_saved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['avatar_original'] = this.avatarOriginal;
    data['phone'] = this.phone;
    data['password_saved'] = this.passwordSaved;
    return data;
  }
}

class SignupResendOtpResponse {
  bool? result;
  String? phone;
  String? message;

  SignupResendOtpResponse({
    this.result,
    this.phone,
    this.message,
  });

  SignupResendOtpResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    phone = json['phone'];
    message = json['message'];
    //user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['phone'] = this.phone;
    data['message'] = this.message;
    return data;
  }
}