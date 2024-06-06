import 'dart:convert';

class CheckoutSummaryResponse {
  String? subTotal;
  String? tax;
  String? shippingCost;
  String? discount;
  String? grandTotal;
  double? grandTotalValue;
  dynamic couponCode;
  bool? couponApplied;

  CheckoutSummaryResponse({
    this.subTotal,
    this.tax,
    this.shippingCost,
    this.discount,
    this.grandTotal,
    this.grandTotalValue,
    this.couponCode,
    this.couponApplied,
  });

  factory CheckoutSummaryResponse.fromRawJson(String str) => CheckoutSummaryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckoutSummaryResponse.fromJson(Map<String, dynamic> json) => CheckoutSummaryResponse(
    subTotal: json["sub_total"],
    tax: json["tax"],
    shippingCost: json["shipping_cost"],
    discount: json["discount"],
    grandTotal: json["grand_total"],
    grandTotalValue: json["grand_total_value"]?.toDouble(),
    couponCode: json["coupon_code"],
    couponApplied: json["coupon_applied"],
  );

  Map<String, dynamic> toJson() => {
    "sub_total": subTotal,
    "tax": tax,
    "shipping_cost": shippingCost,
    "discount": discount,
    "grand_total": grandTotal,
    "grand_total_value": grandTotalValue,
    "coupon_code": couponCode,
    "coupon_applied": couponApplied,
  };
}
