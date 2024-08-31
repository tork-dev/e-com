import 'dart:convert';

class BusinessSettingResponse {
  List<Datum>? data;
  bool? success;
  int? status;

  BusinessSettingResponse({
    this.data,
    this.success,
    this.status,
  });

  factory BusinessSettingResponse.fromRawJson(String str) => BusinessSettingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BusinessSettingResponse.fromJson(Map<String, dynamic> json) => BusinessSettingResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
  String? type;
  String? value;

  Datum({
    this.type,
    this.value,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}


class PopUp {
  int? id;
  String? title;
  String? description;
  String? image;
  String? buttonName;
  String? route;
  String? source;

  PopUp({
    this.id,
    this.title,
    this.description,
    this.image,
    this.buttonName,
    this.route,
    this.source
  });

  factory PopUp.fromRawJson(String str) => PopUp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopUp.fromJson(Map<String, dynamic> json) =>
      PopUp(
          id: json["id"],
          title: json["title"],
          description: json["description"],
          image: json["image"],
          buttonName: json["button_name"],
          route: json["route"],
          source: json["source"]
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "button_name": buttonName,
        "route": route,
        "source": source,
      };
}

