import 'dart:convert';

class GroupShoppingCheckoutResponse {
  bool? result;
  String? message;
  dynamic data;

  GroupShoppingCheckoutResponse({
    this.result,
    this.message,
    this.data,
  });

  factory GroupShoppingCheckoutResponse.fromJson(String str) => GroupShoppingCheckoutResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupShoppingCheckoutResponse.fromMap(Map<String, dynamic> json) => GroupShoppingCheckoutResponse(
    result: json["result"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toMap() => {
    "result": result,
    "message": message,
    "data": data,
  };
}
