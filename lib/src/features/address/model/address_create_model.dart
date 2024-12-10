class AddressCreateResponse {
  bool? result;
  String? message;

  AddressCreateResponse({this.result, this.message});

  factory AddressCreateResponse.fromJson(Map<String, dynamic> json) {
    return AddressCreateResponse(
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
