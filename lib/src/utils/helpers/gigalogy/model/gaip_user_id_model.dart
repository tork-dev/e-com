import 'dart:convert';

class GaipUserIdResponse {
  Detail? detail;

  GaipUserIdResponse({
    this.detail,
  });

  factory GaipUserIdResponse.fromRawJson(String str) => GaipUserIdResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GaipUserIdResponse.fromJson(Map<String, dynamic> json) => GaipUserIdResponse(
    detail: Detail.fromJson(json["detail"]),
  );

  Map<String, dynamic> toJson() => {
    "detail": detail?.toJson(),
  };
}

class Detail {
  String? response;

  Detail({
    this.response,
  });

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    response: json["response"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
  };
}
