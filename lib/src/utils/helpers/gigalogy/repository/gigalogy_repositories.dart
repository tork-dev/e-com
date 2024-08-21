import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';

import '../../../local_storage/local_storage_keys.dart';
import '../../../local_storage/storage_utility.dart';
import '../model/gaip_user_id_model.dart';
import 'package:http/http.dart' as http;

class GigalogyRepository {
  static final String projectKey = dotenv.env["GIGALOGY_PROJECT_KEY"]!;
  static final String apiKey = dotenv.env["GIGALOGY_API_KEY"]!;

  final String? memberId =
      AppLocalStorage().readData(LocalStorageKeys.userEmail).toString();
  final String? userName =
      AppLocalStorage().readData(LocalStorageKeys.userName);
  final String? gaipUserId =
      AppLocalStorage().readData(LocalStorageKeys.gaipUserId);

  Future<GaipUserIdResponse> getGaipUserId() async {
    Uri url = Uri.parse(AppApiEndPoints.generateGaipUserId);
    final response = await http
        .get(url, headers: {"project-key": projectKey, "api-key": apiKey});
    print(url);
    print(response.body.toString());
    return GaipUserIdResponse.fromJson(jsonDecode(response.body));
  }

  Future<http.Response> sendDetailsEvent(String itemSlug) async {
    final response = await http
        .post(Uri.parse(AppApiEndPoints.detailsPageEvent), headers: {
      'project-key': projectKey,
      'api-key': apiKey
    }, body: {
      "user_id": gaipUserId,
      "member_id": memberId,
      "item_id": itemSlug
    });
    return response;
  }

  Future<http.Response> sendChoosingDataEvent(
      {required String itemSlug, String rating = "1", String? feedback}) async {
    final response =
        await http.post(Uri.parse(AppApiEndPoints.userChoosingEvent), headers: {
      'project-key': projectKey,
      'api-key': apiKey
    }, body: {
      "user_id": gaipUserId,
      "member_id": memberId,
      "item_id": itemSlug,
      "rating": "1",
      "feedback": feedback
    });
    return response;
  }


  Future<http.Response> sendPurchaseDataEvent(
      {required List<Map<String, dynamic>> items}) async {
    final response =
    await http.post(Uri.parse(AppApiEndPoints.userChoosingEvent), headers: {
      'project-key': projectKey,
      'api-key': apiKey
    }, body: {
      "user_id": gaipUserId,
      "member_id": memberId,
      "item_list" : items
    });
    return response;
  }

  Future<http.Response> sendUserDataEvent(
      {required Map<String, dynamic> userData}) async {
    final response =
    await http.post(Uri.parse(AppApiEndPoints.userChoosingEvent), headers: {
      'project-key': projectKey,
      'api-key': apiKey
    }, body: {
      "user_id": gaipUserId,
      "member_id": memberId,
      "user_info" : userData
    });
    return response;
  }

}
