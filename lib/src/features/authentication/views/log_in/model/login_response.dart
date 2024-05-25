class AppLoginResponse {
  bool? result;
  String? message;
  String? phone;
  String? accessToken;
  String? tokenType;
  String? expiresAt;
  User? user;

  AppLoginResponse({
    this.result,
    this.message,
    this.phone,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
  });

  factory AppLoginResponse.fromJson(Map<String, dynamic> json) {
    return AppLoginResponse(
      result: json['result'],
      message: json['message'],
      phone: json['phone'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresAt: json['expires_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
      'phone': phone,
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_at': expiresAt,
      'user': user?.toJson(),
    };
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

  User({
    this.id,
    this.type,
    this.name,
    this.email,
    this.avatar,
    this.avatarOriginal,
    this.phone,
    this.passwordSaved,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      avatarOriginal: json['avatar_original'],
      phone: json['phone'],
      passwordSaved: json['password_saved'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'email': email,
      'avatar': avatar,
      'avatar_original': avatarOriginal,
      'phone': phone,
      'password_saved': passwordSaved,
    };
  }
}
