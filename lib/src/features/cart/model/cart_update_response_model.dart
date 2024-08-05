class CartUpdateResponse {
  bool? result;
  String? message;
  dynamic cartQuantity;

  CartUpdateResponse({this.result, this.message, this.cartQuantity});

  factory CartUpdateResponse.fromJson(Map<String, dynamic> json) {
    return CartUpdateResponse(
      result: json['result'],
      message: json['message'],
      cartQuantity: json['cart_quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
      'cart_quantity': cartQuantity,
    };
  }
}
