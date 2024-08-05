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

class OrderData {
  int? id;
  ShippingAddress? shippingAddress;
  int? userId;
  String? paymentType;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  dynamic couponCode;
  double? couponDiscount;
  double? shippingCost;
  String? deliveryStatusString;
  String? grandTotal;
  double? subtotal;
  String? date;
  Links? links;

  OrderData({
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

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      shippingAddress: json['shipping_address'] != null
          ? ShippingAddress.fromJson(json['shipping_address'])
          : null,
      userId: json['user_id'],
      paymentType: json['payment_type'],
      paymentStatus: json['payment_status'],
      paymentStatusString: json['payment_status_string'],
      deliveryStatus: json['delivery_status'],
      couponCode: json['coupon_code'],
      couponDiscount: (json['coupon_discount'] as num?)?.toDouble(),
      shippingCost: (json['shipping_cost'] as num?)?.toDouble(),
      deliveryStatusString: json['delivery_status_string'],
      grandTotal: json['grand_total'],
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      date: json['date'],
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shipping_address': shippingAddress?.toJson(),
      'user_id': userId,
      'payment_type': paymentType,
      'payment_status': paymentStatus,
      'payment_status_string': paymentStatusString,
      'delivery_status': deliveryStatus,
      'coupon_code': couponCode,
      'coupon_discount': couponDiscount,
      'shipping_cost': shippingCost,
      'delivery_status_string': deliveryStatusString,
      'grand_total': grandTotal,
      'subtotal': subtotal,
      'date': date,
      'links': links?.toJson(),
    };
  }
}

class PurchaseHistoryResponse {
  List<OrderData>? data;

  PurchaseHistoryResponse({this.data});

  factory PurchaseHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseHistoryResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => OrderData.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}