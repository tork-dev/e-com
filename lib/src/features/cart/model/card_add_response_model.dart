class AddToCartResponse {
  bool? result;
  String? message;
  dynamic cartQuantity;
  dynamic data;

  AddToCartResponse({
    this.result,
    this.message,
    this.cartQuantity,
    this.data,
  });

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) {
    return AddToCartResponse(
      result: json['result'],
      message: json['message'],
      cartQuantity: json.containsKey('cart_quantity') ? json['cart_quantity'] : null,
      data: json.containsKey('data') ? json['data'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
      'cart_quantity': cartQuantity,
      'data': data,
    };
  }

  @override
  String toString() {
    return 'AddToCartResponse(result: $result, message: $message, cartQuantity: $cartQuantity, data: $data)';
  }
}
