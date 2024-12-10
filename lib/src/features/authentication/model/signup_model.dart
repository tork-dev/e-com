// // To parse this JSON data, do
// //
// //     final signupResponse = signupResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'login_model.dart';
//
//
//
// SignupResponse signupResponseFromJson(String str) =>
//     SignupResponse.fromJson(json.decode(str));
//
// String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());
//
// SignUpOtpResponse signUpOtpResponseFromJson(String str) =>
//     SignUpOtpResponse.fromJson(json.decode(str));
//
// String signUpOtpResponseToJson(SignUpOtpResponse data) =>
//     json.encode(data.toJson());
//
// class SignupResponse {
//   SignupResponse(
//       {this.result,
//         this.message,
//         this.userId,
//         this.accessToken,
//         this.tokenType,
//         this.user,
//         this.phone});
//
//   bool? result;
//   String? message;
//   int? userId;
//   String? accessToken;
//   String ?tokenType;
//   User? user;
//   String? phone;
//
//   factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
//     result: json["result"],
//     message: json["message"],
//     userId: json["user_id"],
//     accessToken:
//     json["access_token"],
//     tokenType: json["token_type"],
//     user: json["user"] == null ? null : User.fromJson(json["user"]),
//     phone: json["phone"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "result": result,
//     "message": message,
//     "user_id": userId,
//     "access_token": accessToken,
//     "token_type": tokenType,
//     "user": user?.toJson(),
//     "phone": phone
//   };
// }
//
// class SignUpOtpResponse {
//   SignUpOtpResponse({
//     this.result,
//     this.phone,
//     this.message,
//   });
//
//   bool? result;
//   String? phone;
//   String? message;
//
//   factory SignUpOtpResponse.fromJson(Map<String, dynamic> json) =>
//       SignUpOtpResponse(
//         result: json['result'],
//         phone: json['phone'],
//         message: json['message'],
//       );
//
//   Map<String, dynamic> toJson() => {
//     'result': result,
//     'phone': phone,
//     'message': message,
//   };
// }
