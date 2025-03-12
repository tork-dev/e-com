import 'dart:convert';
import 'package:kirei/src/features/authentication/views/forgot_password/model/forget_password_confrim_response.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import '../../../../../utils/logging/logger.dart';
import '../../../model/resend_code_model.dart';
import '../controllers/forgot_password_controllers.dart';
import '../model/forgot_password_reponse.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordRepository{

  final forgetPassController = ForgotPasswordController.instance;

  Future<ForgotPasswordResponse> getForgetPasswordResponse(
       String emailOrPhone) async {
    var postBody = jsonEncode({"email": emailOrPhone});

    Uri url = Uri.parse(
      AppApiEndPoints.forgetPasswordOtpSend
    );
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    Log.d(response.body.toString());

    return passwordForgetResponseFromJson(response.body);
  }

  Future<ForgetPasswordConfirmResponse> getPasswordConfirmResponse(
      String verificationCode,  String phone) async {
    var postBody =
    jsonEncode({"otp_code": verificationCode, "email": phone});

    Uri url = Uri.parse(AppApiEndPoints.forgetConfirmPassword
    );
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    Log.d(response.body.toString());

    return forgetPasswordConfirmResponseFromJson(response.body);
  }


  Future<SendOtpCodeResponse> getResendForgetPasswordResponse(
      String emailOrPhone) async {
    var postBody = jsonEncode({"email": emailOrPhone});

    Uri url = Uri.parse(
        AppApiEndPoints.forgetPasswordOtpSend
    );
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    Log.d(response.body);

    return resendCodeResponseFromJson(response.body);
  }


}