class AddToCartResponse {
  bool? result;
  String? message;
  dynamic cartQuantity;

  AddToCartResponse({this.result, this.message, this.cartQuantity});

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) {
    return AddToCartResponse(
      result: json['result'],
      message: json['message'],
      cartQuantity: json['cart_quantity'],
    );
  }

  @override
  String toString() {
    return 'CartResponse(result: $result, message: $message, cartQuantity: $cartQuantity)';
  }
}
