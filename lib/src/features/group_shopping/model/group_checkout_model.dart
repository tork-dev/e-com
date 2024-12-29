import 'dart:convert';

class GroupShoppingCheckoutResponse {
  bool? result;
  String? message;
  Data? data;

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
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "result": result,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  String? paymentUrl;

  Data({
    this.paymentUrl,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    paymentUrl: json["payment_url"],
  );

  Map<String, dynamic> toMap() => {
    "payment_url": paymentUrl,
  };
}
