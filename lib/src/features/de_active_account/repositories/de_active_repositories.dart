import 'dart:convert';

import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../model/de_active_model.dart';
import 'package:http/http.dart' as http;

class DeActiveRepo{
  Future<DeActiveAccountResponse> deActiveUserAccount() async{
    final response = await http.post(Uri.parse(AppApiEndPoints.deActiveAccount),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}",
        },
        body: jsonEncode({
          "source" : "app"
        })
    );

    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return DeActiveAccountResponse.fromJson(responseBody);
    }else{
      throw Error();
    }
  }
}