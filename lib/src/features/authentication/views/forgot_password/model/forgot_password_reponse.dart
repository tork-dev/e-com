import 'dart:convert';


ForgotPasswordResponse passwordForgetResponseFromJson(String str) => ForgotPasswordResponse.fromJson(json.decode(str));

String passwordForgetResponseToJson(ForgotPasswordResponse data) => json.encode(data.toJson());

class ForgotPasswordResponse {
  bool? result;
  String? phone;
  String? message;

  ForgotPasswordResponse({this.result, this.phone, this.message});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
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