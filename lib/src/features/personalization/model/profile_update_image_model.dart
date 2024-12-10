class ProfileUpdateImageResponse {
  bool? result;
  String? message;
  String? path;

  ProfileUpdateImageResponse({this.result, this.message, this.path});

  factory ProfileUpdateImageResponse.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateImageResponse(
      result: json['result'],
      message: json['message'],
      path: json["path"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
      'path': path,
    };
  }
}
