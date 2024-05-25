class WishlistRemoveResponse {
  bool? result;
  String? message;

  WishlistRemoveResponse({this.result, this.message});

  factory WishlistRemoveResponse.fromJson(Map<String, dynamic> json) {
    return WishlistRemoveResponse(
      result: json['result'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
    };
  }
}
