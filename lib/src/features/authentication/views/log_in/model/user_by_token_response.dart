import 'dart:convert';

import 'package:flutter/material.dart';

UserByTokenResponse userByTokenResponseFromJson(String str) => UserByTokenResponse.fromJson(json.decode(str));

String userByTokenResponseToJson(UserByTokenResponse data) => json.encode(data.toJson());

class UserByTokenResponse {
  bool? result;
  int? id;
  String? name;
  String? email;
  String? avatar;
  String? avatarOriginal;
  String? phone;
  bool? passwordSaved;

  UserByTokenResponse(
      {this.result,
        this.id,
        this.name,
        this.email,
        this.avatar,
        this.avatarOriginal,
        this.phone,
        this.passwordSaved});

  UserByTokenResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    phone = json['phone'];
    passwordSaved = json['password_saved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['avatar_original'] = this.avatarOriginal;
    data['phone'] = this.phone;
    data['password_saved'] = this.passwordSaved;
    return data;
  }
}