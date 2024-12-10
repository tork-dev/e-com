import 'dart:convert';

class AddressResponse {
  List<Datum>? data;
  bool? success;
  int? status;

  AddressResponse({
    this.data,
    this.success,
    this.status,
  });

  factory AddressResponse.fromJson(String str) => AddressResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressResponse.fromMap(Map<String, dynamic> json) => AddressResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "success": success,
    "status": status,
  };
}

class Datum {
  int? id;
  int? userId;
  String? address;
  int? countryId;
  dynamic countryName;
  int? cityId;
  String? cityName;
  int? zoneId;
  String? zoneName;
  int? areaId;
  String? areaName;
  dynamic postalCode;
  String? phone;
  String? name;
  dynamic email;
  int? setDefault;
  bool? locationAvailable;
  double? lat;
  double? lang;

  Datum({
    this.id,
    this.userId,
    this.address,
    this.countryId,
    this.countryName,
    this.cityId,
    this.cityName,
    this.zoneId,
    this.zoneName,
    this.areaId,
    this.areaName,
    this.postalCode,
    this.phone,
    this.name,
    this.email,
    this.setDefault,
    this.locationAvailable,
    this.lat,
    this.lang,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    zoneId: json["zone_id"],
    zoneName: json["zone_name"],
    areaId: json["area_id"],
    areaName: json["area_name"],
    postalCode: json["postal_code"],
    phone: json["phone"],
    name: json["name"],
    email: json["email"],
    setDefault: json["set_default"],
    locationAvailable: json["location_available"],
    lat: json["lat"]?.toDouble(),
    lang: json["lang"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "country_id": countryId,
    "country_name": countryName,
    "city_id": cityId,
    "city_name": cityName,
    "zone_id": zoneId,
    "zone_name": zoneName,
    "area_id": areaId,
    "area_name": areaName,
    "postal_code": postalCode,
    "phone": phone,
    "name": name,
    "email": email,
    "set_default": setDefault,
    "location_available": locationAvailable,
    "lat": lat,
    "lang": lang,
  };
}
