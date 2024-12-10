import 'dart:convert';

class BusinessSettingResponse {
  List<BusinessSettingResponseDatum>? data;
  Popup? popup;
  bool? success;
  int? status;

  BusinessSettingResponse({
    this.data,
    this.popup,
    this.success,
    this.status,
  });

  factory BusinessSettingResponse.fromJson(String str) => BusinessSettingResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessSettingResponse.fromMap(Map<String, dynamic> json) => BusinessSettingResponse(
    data: json["data"] == null ? [] : List<BusinessSettingResponseDatum>.from(json["data"]!.map((x) => BusinessSettingResponseDatum.fromMap(x))),
    popup: json["popup"] == null ? null : Popup.fromMap(json["popup"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "popup": popup?.toMap(),
    "success": success,
    "status": status,
  };
}

class BusinessSettingResponseDatum {
  String? type;
  String? value;

  BusinessSettingResponseDatum({
    this.type,
    this.value,
  });

  factory BusinessSettingResponseDatum.fromJson(String str) => BusinessSettingResponseDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessSettingResponseDatum.fromMap(Map<String, dynamic> json) => BusinessSettingResponseDatum(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "value": value,
  };
}

class Popup {
  List<PopupDatum>? data;
  int? interval;

  Popup({
    this.data,
    this.interval,
  });

  factory Popup.fromJson(String str) => Popup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Popup.fromMap(Map<String, dynamic> json) => Popup(
    data: json["data"] == null ? [] : List<PopupDatum>.from(json["data"]!.map((x) => PopupDatum.fromMap(x))),
    interval: json["interval"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "interval": interval,
  };
}

class PopupDatum {
  int? id;
  String? title;
  String? description;
  String? image;
  String? buttonName;
  String? route;
  String? source;

  PopupDatum({
    this.id,
    this.title,
    this.description,
    this.image,
    this.buttonName,
    this.route,
    this.source,
  });

  factory PopupDatum.fromJson(String str) => PopupDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PopupDatum.fromMap(Map<String, dynamic> json) => PopupDatum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    buttonName: json["button_name"],
    route: json["route"],
    source: json["source"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "button_name": buttonName,
    "route": route,
    "source": source,
  };
}
