class AddressResponse {
  List<AddressData>? data;
  bool? success;
  int? status;

  AddressResponse({this.data, this.success, this.status});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => AddressData.fromJson(i)).toList()
          : null,
      success: json['success'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((v) => v.toJson()).toList(),
      'success': success,
      'status': status,
    };
  }
}

class AddressData {
  int? id;
  int? userId;
  String? address;
  int? countryId;
  String? countryName;
  int? cityId;
  String? cityName;
  int? zoneId;
  String? zoneName;
  int? areaId;
  String? areaName;
  String? postalCode;
  String? phone;
  String? name;
  String? email;
  int? setDefault;
  bool? locationAvailable;
  double? lat;
  double? lang;

  AddressData({
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

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      id: json['id'],
      userId: json['user_id'],
      address: json['address'],
      countryId: json['country_id'],
      countryName: json['country_name'],
      cityId: json['city_id'],
      cityName: json['city_name'],
      zoneId: json['zone_id'],
      zoneName: json['zone_name'],
      areaId: json['area_id'],
      areaName: json['area_name'],
      postalCode: json['postal_code'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
      setDefault: json['set_default'],
      locationAvailable: json['location_available'],
      lat: (json['lat'] as num?)?.toDouble(),
      lang: (json['lang'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'address': address,
      'country_id': countryId,
      'country_name': countryName,
      'city_id': cityId,
      'city_name': cityName,
      'zone_id': zoneId,
      'zone_name': zoneName,
      'area_id': areaId,
      'area_name': areaName,
      'postal_code': postalCode,
      'phone': phone,
      'name': name,
      'email': email,
      'set_default': setDefault,
      'location_available': locationAvailable,
      'lat': lat,
      'lang': lang,
    };
  }
}
