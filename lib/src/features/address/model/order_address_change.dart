import 'dart:convert';

ShippingResponse shippingResponseFromJson(String str) => ShippingResponse.fromJson(json.decode(str));

String shippingResponseToJson(ShippingResponse data) => json.encode(data.toJson());

class ShippingResponse {
  bool? result;
  String? message;
  ShippingData? data;

  ShippingResponse({
    this.result,
    this.message,
    this.data,
  });

  factory ShippingResponse.fromJson(Map<String, dynamic> json) => ShippingResponse(
    result: json['result'],
    message: json['message'],
    data: json['data'] == null ? null : ShippingData.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };
}

class ShippingData {
  int? id;
  dynamic combinedOrderId;
  int? isPreorder;
  dynamic membershipId;
  int? userId;
  int? apiCredentialId;
  String? orderSource;
  dynamic guestId;
  dynamic sellerId;
  String? shippingAddress;
  String? shippingType;
  int? shippingCost;
  int? pickupPointId;
  String? deliveryStatus;
  dynamic pathaoResponse;
  String? paymentType;
  String? paymentStatus;
  dynamic transactionId;
  dynamic paymentFrom;
  dynamic paymentDetails;
  dynamic refundDetails;
  int? grandTotal;
  dynamic couponCode;
  int? couponDiscount;
  int? isRecurring;
  int? isRequest;
  int? isRequestConfirmed;
  dynamic code;
  dynamic trackingCode;
  int? date;
  int? viewed;
  int? deliveryViewed;
  int? paymentStatusViewed;
  int? commissionCalculated;
  dynamic note;
  DateTime? createdAt;
  DateTime? updatedAt;

  ShippingData({
    this.id,
    this.combinedOrderId,
    this.isPreorder,
    this.membershipId,
    this.userId,
    this.apiCredentialId,
    this.orderSource,
    this.guestId,
    this.sellerId,
    this.shippingAddress,
    this.shippingType,
    this.shippingCost,
    this.pickupPointId,
    this.deliveryStatus,
    this.pathaoResponse,
    this.paymentType,
    this.paymentStatus,
    this.transactionId,
    this.paymentFrom,
    this.paymentDetails,
    this.refundDetails,
    this.grandTotal,
    this.couponCode,
    this.couponDiscount,
    this.isRecurring,
    this.isRequest,
    this.isRequestConfirmed,
    this.code,
    this.trackingCode,
    this.date,
    this.viewed,
    this.deliveryViewed,
    this.paymentStatusViewed,
    this.commissionCalculated,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory ShippingData.fromJson(Map<String, dynamic> json) => ShippingData(
    id: json['id'],
    combinedOrderId: json['combined_order_id'],
    isPreorder: json['is_preorder'],
    membershipId: json['membership_id'],
    userId: json['user_id'],
    apiCredentialId: json['api_credential_id'],
    orderSource: json['order_source'],
    guestId: json['guest_id'],
    sellerId: json['seller_id'],
    shippingAddress: json['shipping_address'],
    shippingType: json['shipping_type'],
    shippingCost: json['shipping_cost'],
    pickupPointId: json['pickup_point_id'],
    deliveryStatus: json['delivery_status'],
    pathaoResponse: json['pathao_response'],
    paymentType: json['payment_type'],
    paymentStatus: json['payment_status'],
    transactionId: json['transaction_id'],
    paymentFrom: json['payment_from'],
    paymentDetails: json['payment_details'],
    refundDetails: json['refund_details'],
    grandTotal: json['grand_total'],
    couponCode: json['coupon_code'],
    couponDiscount: json['coupon_discount'],
    isRecurring: json['is_recurring'],
    isRequest: json['is_request'],
    isRequestConfirmed: json['is_request_confirmed'],
    code: json['code'],
    trackingCode: json['tracking_code'],
    date: json['date'],
    viewed: json['viewed'],
    deliveryViewed: json['delivery_viewed'],
    paymentStatusViewed: json['payment_status_viewed'],
    commissionCalculated: json['commission_calculated'],
    note: json['note'],
    createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "combined_order_id": combinedOrderId,
    "is_preorder": isPreorder,
    "membership_id": membershipId,
    "user_id": userId,
    "api_credential_id": apiCredentialId,
    "order_source": orderSource,
    "guest_id": guestId,
    "seller_id": sellerId,
    "shipping_address": shippingAddress,
    "shipping_type": shippingType,
    "shipping_cost": shippingCost,
    "pickup_point_id": pickupPointId,
    "delivery_status": deliveryStatus,
    "pathao_response": pathaoResponse,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "transaction_id": transactionId,
    "payment_from": paymentFrom,
    "payment_details": paymentDetails,
    "refund_details": refundDetails,
    "grand_total": grandTotal,
    "coupon_code": couponCode,
    "coupon_discount": couponDiscount,
    "is_recurring": isRecurring,
    "is_request": isRequest,
    "is_request_confirmed": isRequestConfirmed,
    "code": code,
    "tracking_code": trackingCode,
    "date": date,
    "viewed": viewed,
    "delivery_viewed": deliveryViewed,
    "payment_status_viewed": paymentStatusViewed,
    "commission_calculated": commissionCalculated,
    "note": note,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
