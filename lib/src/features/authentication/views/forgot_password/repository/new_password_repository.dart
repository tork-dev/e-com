import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/authentication/views/forgot_password/model/new_password_response.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';

class NewPasswordRepository{


  Future<NewPasswordResponse> getConfirmReset(
       String verificationCode,
       String phone,
       bool otpReset,
       String password) async {
    var postBody = jsonEncode({
      "otp_code": verificationCode,
      "email": phone,
      "otp_reset": otpReset,
      "password": password
    });
    //print(postBody);

    Uri url = Uri.parse(AppApiEndPoints.passwordConfirmReset);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    //print(response.body.toString());

    return newPasswordResponseFromJson(response.body);
  }


}