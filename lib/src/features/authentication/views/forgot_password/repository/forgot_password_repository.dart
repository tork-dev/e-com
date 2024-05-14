import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:torganic/src/utils/constants/app_api_end_points.dart';

import '../controllers/forgot_password_controllers.dart';
import '../model/forgot_password_reponse.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordRepository{

  final forgetPassController = ForgotPasswordController.instance;

  Future<ForgotPasswordResponse> getPasswordForgetResponse(
       String emailOrPhone) async {
    var postBody = jsonEncode({"email": emailOrPhone});

    print(postBody);
    Uri url = Uri.parse(
      AppApiEndPoints.forgetPasswordOtpSend
    );
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    print("Response body:"+response.body.toString());

    return passwordForgetResponseFromJson(response.body);
  }







}