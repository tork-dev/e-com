import 'dart:convert';
import 'package:kirei/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:kirei/src/features/authentication/views/sign_up/controllers/signup_controller.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import '../../../model/resend_code_model.dart';
import '../model/signup_response.dart';

class SignupRepository{
  final signupController = SignUpPageController.instance;

  Future<SignupResponse> getSignupResponse(
       String name,
       String emailOrPhone,
       String password,
       String passwordConfirmation,
       String registerBy,
      ) async {
    var postBody = jsonEncode({
      "name": name,
      "email_or_phone": emailOrPhone,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "register_by": registerBy,
      //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
    });

    Uri url = Uri.parse(AppApiEndPoints.signUp);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          //"App-Language": app_language.$,
        },
        body: postBody);
    print("Request data: $postBody");
    print(response.body);
    return signupResponseFromJson(response.body);
  }

  Future<SignupResponse> getSignupOtpResponse(
       String phone
      ) async {
    var postBody = jsonEncode({
      "email": phone,
      //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
    });
    print(postBody);
    Uri url = Uri.parse(AppApiEndPoints.signupOtp);
    print(url);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print("SignUpResponse:"+response.body.toString());
    return signupResponseFromJson(response.body);
  }

  Future<AppLoginResponse> getSignUpOtpConfirmCodeResponse(
       String phone,  String verificationCode) async {
    var postBody =
    jsonEncode({"email": phone, "otp_code": verificationCode});

    Uri url = Uri.parse(AppApiEndPoints.verifySignUpOtp);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);
    return AppLoginResponse.fromJson(jsonDecode(response.body));
  }


  Future<SendOtpCodeResponse> getResendSignupOtpResponse(
      String phone
      ) async {
    var postBody = jsonEncode({
      "email": phone,
      //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
    });
    Uri url = Uri.parse(AppApiEndPoints.signupOtp);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);
    return resendCodeResponseFromJson(response.body);
  }

}