class City {
  int? id;
  String? name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class CityResponse {
  List<City>? cities;
  bool? success;
  bool? result;
  int? status;

  CityResponse({
    this.cities,
    this.success,
    this.result,
    this.status,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) {
    return CityResponse(
      cities: (json['data']['cities'] as List?)?.map((cityJson) => City.fromJson(cityJson)).toList(),
      success: json['success'],
      result: json['result'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'cities': cities?.map((city) => city.toJson()).toList(),
      },
      'success': success,
      'result': result,
      'status': status,
    };
  }
}
