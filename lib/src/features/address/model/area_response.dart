class Area {
  int? id;
  String? name;

  Area({this.id, this.name});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
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

class AreaResponse {
  List<Area>? areas;
  bool? success;
  bool? result;
  int? status;

  AreaResponse({this.areas, this.success, this.result, this.status});

  factory AreaResponse.fromJson(Map<String, dynamic> json) {
    return AreaResponse(
      areas: (json['data']['areas'] as List?)?.map((areaJson) => Area.fromJson(areaJson)).toList(),
      success: json['success'],
      result: json['result'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'areas': areas?.map((area) => area.toJson()).toList(),
      },
      'success': success,
      'result': result,
      'status': status,
    };
  }
}
