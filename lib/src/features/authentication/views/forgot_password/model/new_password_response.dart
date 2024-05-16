import 'dart:convert';

import 'package:flutter/material.dart';

NewPasswordResponse newPasswordResponseFromJson(String str) => NewPasswordResponse.fromJson(json.decode(str));

String newPasswordResponseToJson(NewPasswordResponse data) => json.encode(data.toJson());

class NewPasswordResponse {
  bool? result;
  String? message;

  NewPasswordResponse({this.result, this.message});

  NewPasswordResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    return data;
  }
}