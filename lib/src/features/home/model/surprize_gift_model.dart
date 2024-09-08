import 'dart:convert';

class SurprizeGiftResponse {
  bool? result;
  String? message;

  SurprizeGiftResponse({
    this.result,
    this.message,
  });

  factory SurprizeGiftResponse.fromJson(String str) => SurprizeGiftResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurprizeGiftResponse.fromMap(Map<String, dynamic> json) => SurprizeGiftResponse(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "result": result,
    "message": message,
  };
}
