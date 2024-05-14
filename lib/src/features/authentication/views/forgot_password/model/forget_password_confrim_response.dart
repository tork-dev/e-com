import 'dart:convert';

import 'package:flutter/material.dart';

ForgetPasswordConfirmResponse passwordConfirmResponseFromJson(String str) => ForgetPasswordConfirmResponse.fromJson(json.decode(str));

String passwordConfirmResponseToJson(ForgetPasswordConfirmResponse data) => json.encode(data.toJson());

class ForgetPasswordConfirmResponse {
  bool? result;
  String? phone;
  String? message;

  ForgetPasswordConfirmResponse({this.result, this.phone, this.message});

  ForgetPasswordConfirmResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    phone = json['phone'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['phone'] = this.phone;
    data['message'] = this.message;
    return data;
  }
}