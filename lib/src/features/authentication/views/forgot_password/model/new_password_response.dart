import 'dart:convert';


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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    return data;
  }
}