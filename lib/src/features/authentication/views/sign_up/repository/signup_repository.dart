import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:torganic/src/features/authentication/views/sign_up/controllers/signup_controller.dart';
import 'package:http/http.dart' as http;
import 'package:torganic/src/utils/constants/app_api_end_points.dart';

import '../../../../../utils/constants/app_config.dart';
import '../model/signup_response.dart';

class SignupRepository{
  final signupController = SignUpPageController.instance;

  Future<SignupResponse> getSignupResponse(
      @required String name,
      @required String email_or_phone,
      @required String password,
      @required String passowrd_confirmation,
      @required String register_by,
      //@required BuildContext context,
      ) async {
    var post_body = jsonEncode({
      "name": "$name",
      "email_or_phone": "${email_or_phone}",
      "password": "$password",
      "password_confirmation": "${passowrd_confirmation}",
      "register_by": "$register_by",
      //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
    });

    Uri url = Uri.parse("${AppApiEndPoints.signUp}");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          //"App-Language": app_language.$,
        },
        body: post_body);
    print("Request data: ${post_body}");
    print(response.body);
    return signupResponseFromJson(response.body);
  }




}