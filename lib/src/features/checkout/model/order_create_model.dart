import 'dart:convert';

class OrderCreateResponse {
  bool? result;
  String? message;
  Data? data;
  int? code;

  OrderCreateResponse({
    this.result,
    this.message,
    this.data,
    this.code,
  });

  factory OrderCreateResponse.fromRawJson(String str) => OrderCreateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderCreateResponse.fromJson(Map<String, dynamic> json) => OrderCreateResponse(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class Data {
  Order? order;
  dynamic paymentUrl;

  Data({
    this.order,
    this.paymentUrl,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    paymentUrl: json["payment_url"],
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "payment_url": paymentUrl,
  };
}

class Order {
  int? id;
  User? user;
  String? orderSource;
  String? paymentType;
  String? paymentStatus;
  int? deliveryStatus;
  DateTime? date;
  dynamic note;
  dynamic grandTotal;
  int? shippingCost;
  dynamic couponDiscount;
  dynamic rewardPoint;
  ShippingAddress? shippingAddress;
  List<OrderDetail>? orderDetails;

  Order({
    this.id,
    this.user,
    this.orderSource,
    this.paymentType,
    this.paymentStatus,
    this.deliveryStatus,
    this.date,
    this.note,
    this.grandTotal,
    this.shippingCost,
    this.couponDiscount,
    this.rewardPoint,
    this.shippingAddress,
    this.orderDetails,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    orderSource: json["order_source"],
    paymentType: json["payment_type"],
    paymentStatus: json["payment_status"],
    deliveryStatus: json["delivery_status"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    note: json["note"],
    grandTotal: json["grand_total"],
    shippingCost: json["shipping_cost"],
    couponDiscount: json["coupon_discount"],
    rewardPoint: json["reward_point"],
    shippingAddress: json["shipping_address"] == null ? null : ShippingAddress.fromJson(json["shipping_address"]),
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "order_source": orderSource,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "delivery_status": deliveryStatus,
    "date": date?.toIso8601String(),
    "note": note,
    "grand_total": grandTotal,
    "shipping_cost": shippingCost,
    "coupon_discount": couponDiscount,
    "reward_point": rewardPoint,
    "shipping_address": shippingAddress?.toJson(),
    "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
  };
}

class OrderDetail {
  int? id;
  int? productId;
  int? quantity;
  double? unitPrice;
  dynamic totalPrice;
  dynamic discount;
  String? paymentStatus;
  String? deliveryStatus;

  OrderDetail({
    this.id,
    this.productId,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.discount,
    this.paymentStatus,
    this.deliveryStatus,
  });

  factory OrderDetail.fromRawJson(String str) => OrderDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"]?.toDouble(),
    totalPrice: json["total_price"],
    discount: json["discount"],
    paymentStatus: json["payment_status"],
    deliveryStatus: json["delivery_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "quantity": quantity,
    "unit_price": unitPrice,
    "total_price": totalPrice,
    "discount": discount,
    "payment_status": paymentStatus,
    "delivery_status": deliveryStatus,
  };
}

class ShippingAddress {
  String? name;
  dynamic email;
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

  factory ShippingAddress.fromRawJson(String str) => ShippingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
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

  Map<String, dynamic> toJson() => {
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

class User {
  int? id;
  String? name;
  String? email;
  String? avatar;
  String? membership;

  User({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.membership,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    membership: json["membership"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "membership": membership,
  };
}
