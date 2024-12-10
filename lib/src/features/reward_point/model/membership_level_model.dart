import 'dart:convert';

class MemberShipLevelResponse {
  List<Datum>? data;
  bool? result;
  int? status;

  MemberShipLevelResponse({
    this.data,
    this.result,
    this.status,
  });

  factory MemberShipLevelResponse.fromJson(String str) => MemberShipLevelResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MemberShipLevelResponse.fromMap(Map<String, dynamic> json) => MemberShipLevelResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    result: json["result"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "result": result,
    "status": status,
  };
}

class Datum {
  int? id;
  String? title;
  String? description;
  int? minRewardPoint;
  String? icon;

  Datum({
    this.id,
    this.title,
    this.description,
    this.minRewardPoint,
    this.icon
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: json['description'],
    minRewardPoint: json["min_reward_point"],
    icon:  json['icon'],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description" : description,
    "min_reward_point": minRewardPoint,
    'icon' : icon
  };
}
