import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:torganic/src/features/authentication/views/log_in/controllers/login_controller.dart';

import '../../../../../utils/constants/endpoints.dart';
import '../../../../../utils/http/http_client.dart';
import '../../../model/login_model.dart';

class LoginRepository{
  final loginController = LogInPageController.instance;

  Future<Future<Map<String, dynamic>>> getLoginResponse(@required String email,
      @required String password, @required bool remember,) async {
    // var post_body = jsonEncode({
    //   "email": "${email}",
    //   "password": "$password",
    //   "remember_me": remember,
    //   //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
    // });
    var post_body = {
      "email": "${email}",
      "password": "$password",
      "remember_me": remember,
      //"version": "${Provider.of<VersionChange>(context, listen: false).latestVersion}",
    };
    print("before hit api: ${post_body}");
    var response1 = AppHttpHelper.post("${ENDP.LOGIN}", post_body, LoginResponse());
    print("After hit api: ${response1.toString()}");
    // Uri url = Uri.parse("${ENDP.LOGIN}");
    // final response = await http.post(url,
    //     headers: {
    //       "Accept": "*/*",
    //       "Content-Type": "application/json",
    //       "App-Language": app_language.$,
    //     },
    //     body: post_body);
    // print(response.body.toString());
    // return loginResponseFromJson(response.body);
    return response1;
  }










}