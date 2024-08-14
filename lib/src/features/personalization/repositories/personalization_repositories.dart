import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/personalization/model/profile_update_image_model.dart';
import 'package:kirei/src/features/personalization/model/profile_update_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

class PersonalizationRepositories {
  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);

  Future<ProfileUpdateResponse> getProfileUpdateResponse(
      String name, String password, String currentPassword) async {
    var postBody = jsonEncode({
      "name": name,
      "password": password,
      "current_password": currentPassword
    });

    Uri url = Uri.parse(AppApiEndPoints.updateProfile);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    if (response.statusCode == 200) {
      return ProfileUpdateResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Error();
    }
  }

 /// Update Profile Image
  Future<ProfileUpdateImageResponse> getProfileImageUpdateResponse(
      {required String image, required String filename}) async {

    var postBody = jsonEncode( {"image": image, "filename": filename});

    Uri url = Uri.parse(AppApiEndPoints.updateProfileImage);
    final response = await http.post(url,
        headers: {
      "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
          },
        body: postBody );
    var responseBody = jsonDecode(response.body);

    return ProfileUpdateImageResponse.fromJson(responseBody);
  }




}
