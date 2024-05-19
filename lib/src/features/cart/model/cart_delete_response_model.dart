class CartDeleteResponse {
  bool? result;
  String? message;
  String? cartQuantity;

  CartDeleteResponse({this.result, this.message, this.cartQuantity});

  factory CartDeleteResponse.fromJson(Map<String, dynamic> json) {
    return CartDeleteResponse(
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
