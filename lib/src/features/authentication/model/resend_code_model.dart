// To parse this JSON data, do
//
//     final resendCodeResponse = resendCodeResponseFromJson(jsonString);

import 'dart:convert';

SendOtpCodeResponse resendCodeResponseFromJson(String str) => SendOtpCodeResponse.fromJson(json.decode(str));

String resendCodeResponseToJson(SendOtpCodeResponse data) => json.encode(data.toJson());

class SendOtpCodeResponse {
  SendOtpCodeResponse({
    this.result,
    this.phone,
    this.message,
  });

  bool? result;
  String? phone;
  String? message;

  factory SendOtpCodeResponse.fromJson(Map<String, dynamic> json) => SendOtpCodeResponse(
    result: json["result"],
    phone: json["phone"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "phone" : phone,
    "message": message,
  };
}