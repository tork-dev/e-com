class CouponRemoveResponse {
  bool? result;
  String? message;

  CouponRemoveResponse({this.result, this.message});

  // Factory constructor to create a new CouponResponse from JSON
  factory CouponRemoveResponse.fromJson(Map<String, dynamic> json) {
    return CouponRemoveResponse(
      result: json['result'],
      message: json['message'],
    );
  }

  // Method to convert CouponResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
    };
  }
}
