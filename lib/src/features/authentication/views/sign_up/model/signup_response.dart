import 'dart:convert';


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
  dynamic expiresAt;
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_at'] = expiresAt;
    data['phone'] = phone;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  dynamic type;
  String? name;
  String? email;
  String? avatar;
  dynamic avatarOriginal;
  dynamic phone;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    data['avatar_original'] = avatarOriginal;
    data['phone'] = phone;
    data['password_saved'] = passwordSaved;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['phone'] = phone;
    data['message'] = message;
    return data;
  }
}