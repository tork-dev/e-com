import 'dart:convert';

class CheckoutCartUpdateResponse {
  bool? result;
  String? message;

  CheckoutCartUpdateResponse({
    this.result,
    this.message,
  });

  factory CheckoutCartUpdateResponse.fromRawJson(String str) => CheckoutCartUpdateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckoutCartUpdateResponse.fromJson(Map<String, dynamic> json) => CheckoutCartUpdateResponse(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
  };
}
