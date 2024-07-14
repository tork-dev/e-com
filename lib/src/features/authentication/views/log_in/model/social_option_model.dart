class SocialLoginOption {
  int? id;
  String? type;
  String? value;
  String? lang;
  DateTime? createdAt;
  DateTime? updatedAt;

  SocialLoginOption({
    this.id,
    this.type,
    this.value,
    this.lang,
    this.createdAt,
    this.updatedAt,
  });

  factory SocialLoginOption.fromJson(Map<String, dynamic> json) {
    return SocialLoginOption(
      id: json['id'],
      type: json['type'],
      value: json['value'],
      lang: json['lang'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'lang': lang,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class SocialOptionsResponse {
  List<SocialLoginOption>? loginOptions;

  SocialOptionsResponse({this.loginOptions});

  factory SocialOptionsResponse.fromJson(List<dynamic> jsonList) {
    List<SocialLoginOption> options = jsonList.map((json) => SocialLoginOption.fromJson(json)).toList();
    return SocialOptionsResponse(loginOptions: options);
  }

  List<Map<String, dynamic>> toJson() {
    return loginOptions?.map((option) => option.toJson()).toList() ?? [];
  }
}
