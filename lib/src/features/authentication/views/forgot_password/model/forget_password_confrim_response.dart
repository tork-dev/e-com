import 'dart:convert';


ForgetPasswordConfirmResponse forgetPasswordConfirmResponseFromJson(String str) => ForgetPasswordConfirmResponse.fromJson(json.decode(str));

String forgetPasswordConfirmResponseToJson(ForgetPasswordConfirmResponse data) => json.encode(data.toJson());

ResendForgetPasswordResponse resendForgetPasswordResponseFromJson(String str) => ResendForgetPasswordResponse.fromJson(json.decode(str));

String resendForgetPasswordResponseToJson(ForgetPasswordConfirmResponse data) => json.encode(data.toJson());

class ForgetPasswordConfirmResponse {
  final bool? result;
  final String? phone;
  final String? message;

  ForgetPasswordConfirmResponse({
    this.result,
    this.phone,
    this.message,
  });

  factory ForgetPasswordConfirmResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordConfirmResponse(
      result: json['result'],
      phone: json['phone'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (result != null) data['result'] = this.result;
    if (phone != null) data['phone'] = this.phone;
    if (message != null) data['message'] = this.message;
    return data;
  }
}

class ResendForgetPasswordResponse {
  final bool? result;
  final String? phone;
  final String? message;

  ResendForgetPasswordResponse({
    this.result,
    this.phone,
    this.message,
  });

  factory ResendForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResendForgetPasswordResponse(
      result: json['result'],
      phone: json['phone'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (result != null) data['result'] = this.result;
    if (phone != null) data['phone'] = this.phone;
    if (message != null) data['message'] = this.message;
    return data;
  }
}