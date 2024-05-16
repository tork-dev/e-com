import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:torganic/src/features/authentication/views/log_in/controllers/login_controller.dart';


LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

LoginOtpResponse loginOtpResponseFromJson(String str) =>
    LoginOtpResponse.fromJson(json.decode(str));

String loginOtpResponseToJson(LoginOtpResponse data) =>
    json.encode(data.toJson());

LoginResendOtpResponse loginResendOtpResponseFromJson(String str) =>
    LoginResendOtpResponse.fromJson(json.decode(str));

String loginResendOtpResponseToJson(LoginOtpResponse data) =>
    json.encode(data.toJson());

class LoginResponse {
  //final loginController = LogInPageController.instance;
  bool? result;
  String? message;
  String? accessToken;
  String? tokenType;
  DateTime? expiresAt;
  User? user;

  LoginResponse(
      {this.result,
        this.message,
        this.accessToken,
        this.tokenType,
        this.expiresAt,
        this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class LoginOtpResponse {
  bool? result;
  String? phone;
  String? message;

  LoginOtpResponse({
    this.result,
    this.phone,
    this.message,
  });

  LoginOtpResponse.fromJson(Map<String, dynamic> json) {
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

class LoginResendOtpResponse {
  bool? result;
  String? phone;
  String? message;

  LoginResendOtpResponse({
    this.result,
    this.phone,
    this.message,
  });

  LoginResendOtpResponse.fromJson(Map<String, dynamic> json) {
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

class User {
  int? id;
  String? type;
  String? name;
  String? email;
  String? avatar;
  String? avatarOriginal;
  String? phone;
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