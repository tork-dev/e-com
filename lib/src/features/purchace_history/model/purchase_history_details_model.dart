class OrderHistoryDetailsResponse {
  List<OrderData>? data;
  bool? success;
  int? status;

  OrderHistoryDetailsResponse({this.data, this.success, this.status});

  factory OrderHistoryDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDetailsResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => OrderData.fromJson(i)).toList()
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

class OrderData {
  int? id;
  dynamic code;
  int? userId;
  ShippingAddress? shippingAddress;
  String? paymentType;
  dynamic pickupPoint;
  String? shippingType;
  String? shippingTypeString;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;
  String? grandTotal;
  String? couponDiscount;
  String? shippingCost;
  String? subtotal;
  String? tax;
  String? date;
  bool? cancelRequest;
  bool? manuallyPayable;
  Links? links;

  OrderData({
    this.id,
    this.code,
    this.userId,
    this.shippingAddress,
    this.paymentType,
    this.pickupPoint,
    this.shippingType,
    this.shippingTypeString,
    this.paymentStatus,
    this.paymentStatusString,
    this.deliveryStatus,
    this.deliveryStatusString,
    this.grandTotal,
    this.couponDiscount,
    this.shippingCost,
    this.subtotal,
    this.tax,
    this.date,
    this.cancelRequest,
    this.manuallyPayable,
    this.links,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      code: json['code'],
      userId: json['user_id'],
      shippingAddress: json['shipping_address'] != null
          ? ShippingAddress.fromJson(json['shipping_address'])
          : null,
      paymentType: json['payment_type'],
      pickupPoint: json['pickup_point'],
      shippingType: json['shipping_type'],
      shippingTypeString: json['shipping_type_string'],
      paymentStatus: json['payment_status'],
      paymentStatusString: json['payment_status_string'],
      deliveryStatus: json['delivery_status'],
      deliveryStatusString: json['delivery_status_string'],
      grandTotal: json['grand_total'],
      couponDiscount: json['coupon_discount'],
      shippingCost: json['shipping_cost'],
      subtotal: json['subtotal'],
      tax: json['tax'],
      date: json['date'],
      cancelRequest: json['cancel_request'],
      manuallyPayable: json['manually_payable'],
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'user_id': userId,
      'shipping_address': shippingAddress?.toJson(),
      'payment_type': paymentType,
      'pickup_point': pickupPoint,
      'shipping_type': shippingType,
      'shipping_type_string': shippingTypeString,
      'payment_status': paymentStatus,
      'payment_status_string': paymentStatusString,
      'delivery_status': deliveryStatus,
      'delivery_status_string': deliveryStatusString,
      'grand_total': grandTotal,
      'coupon_discount': couponDiscount,
      'shipping_cost': shippingCost,
      'subtotal': subtotal,
      'tax': tax,
      'date': date,
      'cancel_request': cancelRequest,
      'manually_payable': manuallyPayable,
      'links': links?.toJson(),
    };
  }
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

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      name: json['name'],
      email: json['email'],
      address: json['address'],
      cityId: json['city_id'],
      state: json['state'],
      zoneId: json['zone_id'],
      city: json['city'],
      areaId: json['area_id'],
      area: json['area'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'city_id': cityId,
      'state': state,
      'zone_id': zoneId,
      'city': city,
      'area_id': areaId,
      'area': area,
      'phone': phone,
    };
  }
}

class Links {
  String? details;

  Links({this.details});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'details': details,
    };
  }
}
