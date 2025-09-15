import 'dart:convert';

class CheckoutSummaryResponse {
  bool? result;
  String? message;
  Data? data;

  CheckoutSummaryResponse({
    this.result,
    this.message,
    this.data,
  });

  factory CheckoutSummaryResponse.fromRawJson(String str) => CheckoutSummaryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckoutSummaryResponse.fromJson(Map<String, dynamic> json) => CheckoutSummaryResponse(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? subTotal;
  String? tax;
  bool? includeShippingCharge;
  String? shippingCost;
  String? discount;
  String? grandTotal;
  dynamic grandTotalValue;
  String? couponCode;
  bool? couponApplied;

  Data({
    this.subTotal,
    this.tax,
    this.includeShippingCharge,
    this.shippingCost,
    this.discount,
    this.grandTotal,
    this.grandTotalValue,
    this.couponCode,
    this.couponApplied,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    subTotal: json["sub_total"],
    tax: json["tax"],
    includeShippingCharge: json["include_shipping_charge"],
    shippingCost: json["shipping_cost"],
    discount: json["discount"],
    grandTotal: json["grand_total"],
    grandTotalValue: json["grand_total_value"],
    couponCode: json["coupon_code"],
    couponApplied: json["coupon_applied"],
  );

  Map<String, dynamic> toJson() => {
    "sub_total": subTotal,
    "tax": tax,
    "include_shipping_charge": includeShippingCharge,
    "shipping_cost": shippingCost,
    "discount": discount,
    "grand_total": grandTotal,
    "grand_total_value": grandTotalValue,
    "coupon_code": couponCode,
    "coupon_applied": couponApplied,
  };
}
