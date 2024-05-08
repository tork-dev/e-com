import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:torganic/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:torganic/src/features/authentication/views/log_in/model/login_response.dart';
import 'package:torganic/src/utils/constants/app_config.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';

import '../../../../../utils/constants/endpoints.dart';
import '../../../../../utils/http/http_client.dart';
import '../../../../../utils/local_storage/storage_utility.dart';
import '../../../../personalization/model/user_by_token_model.dart';
import '../../../model/login_model.dart';
import 'package:http/http.dart' as http;

import '../model/user_by_token_response.dart';

class LoginRepository{
  final loginController = LogInPageController.instance;

  // Future<Future<Map<String, dynamic>>> getLoginResponse(@required String email,
  //     @required String password, @required bool remember,) async {
  //   // var post_body = jsonEncode({
  //   //   "email": "${email}",
  //   //   "password": "$password",
  //   //   "remember_me": remember,
  //   //   //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
  //   // });
  //   var post_body = {
  //     "email": "${email}",
  //     "password": "$password",
  //     "remember_me": remember,
  //     //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
  //   };
  //   print("before hit api: ${post_body}");
  //   var response1 = AppHttpHelper.post("${ENDP.LOGIN}", post_body, LoginResponse());
  //   print("After hit api: ${response1.toString()}");
  //   // Uri url = Uri.parse("${ENDP.LOGIN}");
  //   // final response = await http.post(url,
  //   //     headers: {
  //   //       "Accept": "*/*",
  //   //       "Content-Type": "application/json",
  //   //       "App-Language": app_language.$,
  //   //     },
  //   //     body: post_body);
  //   // print(response.body.toString());
  //   // return loginResponseFromJson(response.body);
  //   return response1;
  // }

  Future<dynamic> getLoginResponse(@required String email,
      @required String password, @required bool remember_me,) async {
    var post_body = jsonEncode({
      "email": "${email}",
      "password": "$password",
      "remember_me": remember_me,
      //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/${ENDP.LOGIN}");
    final response = await http.post(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          //"App-Language": app_language.$,
        },
        body: post_body);
    print("body data:"+post_body.toString());
    print(response.body.toString());

    return loginResponseFromJson(response.body.toString());
  }

  Future<UserByTokenResponse> getUserByTokenResponse() async {
    final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);
    var post_body = jsonEncode({"access_token": "${accessToken}"});
    Uri url = Uri.parse("${AppConfig.BASE_URL}/get-user-by-access_token");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          //"App-Language": app_language.$,
        },
        body: post_body);

    return userByTokenResponseFromJson(response.body);
  }








}