class PurchaseHistoryItemsResponse {
  List<ProductOrder>? data;
  bool? success;
  int? status;

  PurchaseHistoryItemsResponse({this.data, this.success, this.status});

  factory PurchaseHistoryItemsResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseHistoryItemsResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => ProductOrder.fromJson(i)).toList()
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

class ProductOrder {
  int? id;
  int? productId;
  String? productName;
  dynamic variation;
  String? price;
  String? tax;
  String? shippingCost;
  String? couponDiscount;
  int? quantity;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;
  bool? refundSection;
  bool? refundButton;
  String? refundLabel;
  int? refundRequestStatus;

  ProductOrder({
    this.id,
    this.productId,
    this.productName,
    this.variation,
    this.price,
    this.tax,
    this.shippingCost,
    this.couponDiscount,
    this.quantity,
    this.paymentStatus,
    this.paymentStatusString,
    this.deliveryStatus,
    this.deliveryStatusString,
    this.refundSection,
    this.refundButton,
    this.refundLabel,
    this.refundRequestStatus,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    return ProductOrder(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      variation: json['variation'],
      price: json['price'],
      tax: json['tax'],
      shippingCost: json['shipping_cost'],
      couponDiscount: json['coupon_discount'],
      quantity: json['quantity'],
      paymentStatus: json['payment_status'],
      paymentStatusString: json['payment_status_string'],
      deliveryStatus: json['delivery_status'],
      deliveryStatusString: json['delivery_status_string'],
      refundSection: json['refund_section'],
      refundButton: json['refund_button'],
      refundLabel: json['refund_label'],
      refundRequestStatus: json['refund_request_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'variation': variation,
      'price': price,
      'tax': tax,
      'shipping_cost': shippingCost,
      'coupon_discount': couponDiscount,
      'quantity': quantity,
      'payment_status': paymentStatus,
      'payment_status_string': paymentStatusString,
      'delivery_status': deliveryStatus,
      'delivery_status_string': deliveryStatusString,
      'refund_section': refundSection,
      'refund_button': refundButton,
      'refund_label': refundLabel,
      'refund_request_status': refundRequestStatus,
    };
  }
}
