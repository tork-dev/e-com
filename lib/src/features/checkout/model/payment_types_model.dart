import 'dart:convert';

class PaymentMethodResponse {
  String? paymentType;
  String? paymentTypeKey;
  String? image;
  String? name;
  String? title;
  int? offlinePaymentId;
  String? details;

  PaymentMethodResponse({
    this.paymentType,
    this.paymentTypeKey,
    this.image,
    this.name,
    this.title,
    this.offlinePaymentId,
    this.details,
  });

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) {
    return PaymentMethodResponse(
      paymentType: json['payment_type'],
      paymentTypeKey: json['payment_type_key'],
      image: json['image'],
      name: json['name'],
      title: json['title'],
      offlinePaymentId: json['offline_payment_id'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_type': paymentType,
      'payment_type_key': paymentTypeKey,
      'image': image,
      'name': name,
      'title': title,
      'offline_payment_id': offlinePaymentId,
      'details': details,
    };
  }

  static List<PaymentMethodResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PaymentMethodResponse.fromJson(json)).toList();
  }
}
