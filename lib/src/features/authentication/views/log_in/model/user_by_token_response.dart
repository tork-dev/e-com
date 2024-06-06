class UserByTokenResponse {
  bool? result;
  int? id;
  String? name;
  String? email;
  String? avatar;
  String? avatarOriginal;
  String? phone;
  bool? passwordSaved;

  UserByTokenResponse({
    this.result,
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.avatarOriginal,
    this.phone,
    this.passwordSaved,
  });

  factory UserByTokenResponse.fromJson(Map<String, dynamic> json) {
    return UserByTokenResponse(
      result: json['result'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      avatarOriginal: json['avatar_original'],
      phone: json['phone'],
      passwordSaved: json['password_saved'],
    );
  }
}
