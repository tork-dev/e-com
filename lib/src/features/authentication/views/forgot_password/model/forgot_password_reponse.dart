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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['phone'] = phone;
    data['message'] = message;
    return data;
  }
}