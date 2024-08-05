class ProductRequestResponse {
  bool? result;
  String? message;

  ProductRequestResponse({this.result, this.message});

  factory ProductRequestResponse.fromJson(Map<String, dynamic> json) {
    return ProductRequestResponse(
      result: json['result'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
    };
  }
}
