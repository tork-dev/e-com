import 'dart:convert';

class PurchaseHistoryResponse {
  List<Datum>? data;
  bool? success;
  int? status;

  PurchaseHistoryResponse({
    this.data,
    this.success,
    this.status,
  });

  factory PurchaseHistoryResponse.fromJson(String str) => PurchaseHistoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurchaseHistoryResponse.fromMap(Map<String, dynamic> json) => PurchaseHistoryResponse(
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
  ShippingAddress? shippingAddress;
  int? userId;
  String? paymentType;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? couponCode;
  double? couponDiscount;
  int? shippingCost;
  String? deliveryStatusString;
  String? grandTotal;
  int? subtotal;
  String? date;
  Links? links;

  Datum({
    this.id,
    this.shippingAddress,
    this.userId,
    this.paymentType,
    this.paymentStatus,
    this.paymentStatusString,
    this.deliveryStatus,
    this.couponCode,
    this.couponDiscount,
    this.shippingCost,
    this.deliveryStatusString,
    this.grandTotal,
    this.subtotal,
    this.date,
    this.links,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    shippingAddress: json["shipping_address"] == null ? null : ShippingAddress.fromMap(json["shipping_address"]),
    userId: json["user_id"],
    paymentType: json["payment_type"],
    paymentStatus: json["payment_status"],
    paymentStatusString: json["payment_status_string"],
    deliveryStatus: json["delivery_status"],
    couponCode: json["coupon_code"],
    couponDiscount: json["coupon_discount"]?.toDouble(),
    shippingCost: json["shipping_cost"],
    deliveryStatusString: json["delivery_status_string"],
    grandTotal: json["grand_total"],
    subtotal: json["subtotal"],
    date: json["date"],
    links: json["links"] == null ? null : Links.fromMap(json["links"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "shipping_address": shippingAddress?.toMap(),
    "user_id": userId,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "payment_status_string": paymentStatusString,
    "delivery_status": deliveryStatus,
    "coupon_code": couponCode,
    "coupon_discount": couponDiscount,
    "shipping_cost": shippingCost,
    "delivery_status_string": deliveryStatusString,
    "grand_total": grandTotal,
    "subtotal": subtotal,
    "date": date,
    "links": links?.toMap(),
  };
}

class Links {
  String? details;

  Links({
    this.details,
  });

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
    details: json["details"],
  );

  Map<String, dynamic> toMap() => {
    "details": details,
  };
}

class ShippingAddress {
  String? name;
  String? email;
  String? address;
  int? cityId;
  String? state;
  int? zoneId;
  String? city;
  int? areaId;
  String? area;
  String? phone;

  ShippingAddress({
    this.name,
    this.email,
    this.address,
    this.cityId,
    this.state,
    this.zoneId,
    this.city,
    this.areaId,
    this.area,
    this.phone,
  });

  factory ShippingAddress.fromJson(String str) => ShippingAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingAddress.fromMap(Map<String, dynamic> json) => ShippingAddress(
    name: json["name"],
    email: json["email"],
    address: json["address"],
    cityId: json["city_id"],
    state: json["state"],
    zoneId: json["zone_id"],
    city: json["city"],
    areaId: json["area_id"],
    area: json["area"],
    phone: json["phone"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "address": address,
    "city_id": cityId,
    "state": state,
    "zone_id": zoneId,
    "city": city,
    "area_id": areaId,
    "area": area,
    "phone": phone,
  };
}
