import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:torganic/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:torganic/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:torganic/src/utils/constants/app_config.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';

import '../../../../../utils/constants/app_api_end_points.dart';
import '../../../../../utils/http/http_client.dart';
import '../../../../../utils/local_storage/storage_utility.dart';
import '../../../../personalization/model/user_by_token_model.dart';
import '../../../model/login_model.dart';
import 'package:http/http.dart' as http;

import '../model/user_by_token_response.dart';

class LoginRepository{
  final loginController = LogInPageController.instance;

  Future<dynamic> getLoginOTPResponse( String phone, ) async {
    var postBody = jsonEncode({"email": "${phone}",
      //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
    });

    Uri url = Uri.parse(AppApiEndPoints.loginOtp);
    final response = await http.post(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);
   // return loginResponseFromJson(response.body);
    return loginOtpResponseFromJson(response.body);
  }

  Future<dynamic> getLogInOtpConfirmCodeResponse(
      String phone, String verificationCode) async {
    var postBody =
    jsonEncode({"email": phone, "otp_code": verificationCode});

    Uri url = Uri.parse(AppApiEndPoints.verifyLoginOtp);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body);
    return loginResponseFromJson(response.body);
  }

  Future<dynamic> getLoginResponse( String email,
       String password,  bool remember_me,) async {
    var postBody = jsonEncode({
      "email": "${email}",
      "password": "$password",
      "remember_me": remember_me,
      //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
    });

    Uri url = Uri.parse("${AppApiEndPoints.logIn}");
    final response = await http.post(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        },
        body: postBody);
    print(response.body.toString());

    return loginResponseFromJson(response.body.toString());
  }

  Future<UserByTokenResponse> getUserByTokenResponse() async {
    final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);
    var postBody = jsonEncode({"access_token": "${accessToken}"});
    Uri url = Uri.parse("${AppApiEndPoints.getUserAccessToken}");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    return userByTokenResponseFromJson(response.body);
  }








}