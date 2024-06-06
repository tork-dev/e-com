import 'dart:convert';

class ZoneResponse {
  Data? data;
  bool? success;
  bool? result;
  int? status;

  ZoneResponse({
    this.data,
    this.success,
    this.result,
    this.status,
  });

  factory ZoneResponse.fromRawJson(String str) => ZoneResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ZoneResponse.fromJson(Map<String, dynamic> json) => ZoneResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    success: json["success"],
    result: json["result"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "success": success,
    "result": result,
    "status": status,
  };
}

class Data {
  List<Zone>? zones;

  Data({
    this.zones,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    zones: json["zones"] == null ? [] : List<Zone>.from(json["zones"]!.map((x) => Zone.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zones": zones == null ? [] : List<dynamic>.from(zones!.map((x) => x.toJson())),
  };
}

class Zone {
  int? id;
  String? name;

  Zone({
    this.id,
    this.name,
  });

  factory Zone.fromRawJson(String str) => Zone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
