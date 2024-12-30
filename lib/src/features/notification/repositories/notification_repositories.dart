import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../model/user_notification_response.dart';

class NotificationRepo {
  final String accessToken =
      AppLocalStorage().readData(LocalStorageKeys.accessToken);

  Future<UserNotificationResponse> getNotificationList() async {
    final response = await http
        .get(Uri.parse(AppApiEndPoints.userNotificationList), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });
    return UserNotificationResponse.fromJson(response.body);
  }

  Future<UserNotificationResponse> getNotificationDetails(int notificationId) async {
    final response = await http
        .get(Uri.parse("${AppApiEndPoints.userNotificationList}?notification_id=$notificationId"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });
    return UserNotificationResponse.fromJson(response.body);
  }
}
