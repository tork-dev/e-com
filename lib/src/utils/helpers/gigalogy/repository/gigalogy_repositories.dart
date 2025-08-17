// import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:kirei/src/utils/constants/app_api_end_points.dart';
//
// import '../../../local_storage/local_storage_keys.dart';
// import '../../../local_storage/storage_utility.dart';
// import '../../../logging/logger.dart';
// import '../model/gaip_user_id_model.dart';
// import 'package:http/http.dart' as http;
//
// class GigalogyRepository {
//   static final String projectKey = dotenv.env["GIGALOGY_PROJECT_KEY"]!;
//   static final String apiKey = dotenv.env["GIGALOGY_API_KEY"]!;
//
//   final String? memberId =
//       AppLocalStorage().readData(LocalStorageKeys.userEmail).toString();
//   final String? userName =
//       AppLocalStorage().readData(LocalStorageKeys.userName);
//   final String? gaipUserId =
//       AppLocalStorage().readData(LocalStorageKeys.gaipUserId);
//
//   Future<GaipUserIdResponse> getGaipUserId() async {
//     Uri url = Uri.parse(AppApiEndPoints.generateGaipUserId);
//     final response = await http
//         .get(url, headers: {"project-key": projectKey, "api-key": apiKey});
//     Log.d(url.toString());
//     Log.d(response.body.toString());
//     return GaipUserIdResponse.fromJson(jsonDecode(response.body));
//   }
//
//   Future<void> sendDetailsEvent(String itemSlug) async {
//     await http.post(
//         Uri.parse(AppApiEndPoints.detailsPageEvent),
//         headers: {
//           'Content-Type': 'application/json',
//           'project-key': projectKey,
//           'api-key': apiKey
//         },
//         body: jsonEncode({
//           "user_id": gaipUserId,
//           "member_id": memberId,
//           "item_id": itemSlug
//         }));
//   }
//
//   Future<void> sendChoosingDataEvent(
//       {required String itemSlug, String rating = "1", String? feedBack}) async {
//     Map<String, dynamic> reqBody = {
//       "user_id": gaipUserId,
//       "member_id": memberId,
//       "item_id": itemSlug,
//       "rating": rating,
//     };
//     if (feedBack != null) {
//       reqBody['feedback'] = feedBack;
//     }
//     await http.post(
//         Uri.parse(AppApiEndPoints.userChoosingEvent),
//         headers: {
//           'Content-Type': 'application/json',
//           'project-key': projectKey,
//           'api-key': apiKey
//         },
//         body: jsonEncode(reqBody));
//   }
//
//   Future<void> sendPurchaseDataEvent(
//       {required items}) async {
//     await http.post(
//         Uri.parse(AppApiEndPoints.purchaseEvent),
//         headers: {
//           'Content-Type': 'application/json',
//           'project-key': projectKey,
//           'api-key': apiKey
//         },
//         body: jsonEncode({
//           "user_id": gaipUserId,
//           "member_id": memberId,
//           "item_list": items
//         }));
//   }
//
//   Future<void> sendUserDataEvent() async {
//     await http.post(
//         Uri.parse(AppApiEndPoints.userDataEvent),
//         headers: {
//           'Content-Type': 'application/json',
//           'project-key': projectKey,
//           'api-key': apiKey
//         },
//         body: jsonEncode({
//           "user_id": gaipUserId,
//           "member_id": memberId,
//         }));
//   }
// }
