import 'dart:convert';

class HomeSlidersResponse {
  List<Datum>? data;
  bool? success;
  int? status;

  HomeSlidersResponse({
    this.data,
    this.success,
    this.status,
  });

  factory HomeSlidersResponse.fromRawJson(String str) => HomeSlidersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeSlidersResponse.fromJson(Map<String, dynamic> json) => HomeSlidersResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Datum {
  String? photo;

  Datum({
    this.photo,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
  };
}
