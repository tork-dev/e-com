import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:torganic/src/features/personalization/model/profile_update_image_model.dart';
import 'package:torganic/src/features/personalization/model/profile_update_model.dart';
import 'package:torganic/src/utils/constants/app_api_end_points.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';

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


  // Future<ProfileUpdateImageResponse> updateProfileImage({
  //    required String imagePath,
  //    required String filename,
  // }) async {
  //   Uri url = Uri.parse(AppApiEndPoints.updateProfileImage);
  //
  //   var request = http.MultipartRequest('POST', url)
  //     ..headers['Authorization'] = "Bearer $accessToken"
  //     ..fields['filename'] = filename;
  //
  //   var mimeType = lookupMimeType(imagePath)!.split('/');
  //   var imageFile = await http.MultipartFile.fromPath(
  //     'image',
  //     imagePath,
  //     contentType: MediaType(mimeType[0], mimeType[1]),
  //   );
  //
  //   request.files.add(imageFile);
  //
  //   var streamedResponse = await request.send();
  //   var response = await http.Response.fromStream(streamedResponse);
  //
  //   if (response.statusCode == 200) {
  //     return ProfileUpdateImageResponse.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to update profile image');
  //   }
  // }

  // Future<ProfileUpdateImageResponse> updateProfileImage({required String filename, required File imageFile}) async {
  //   Uri url = Uri.parse(AppApiEndPoints.updateProfileImage);
  //
  //   var multipartRequest = http.MultipartRequest('POST', url);
  //   multipartRequest.headers['Authorization'] = "Bearer $accessToken";
  //
  //   var part = await http.MultipartFile.fromPath('image', imageFile.path,
  //       contentType: MediaType('image', 'jpeg')); // Assuming JPEG image
  //   multipartRequest.files.add(part);
  //   multipartRequest.fields['filename'] = filename;
  //
  //   final response = await multipartRequest.send();
  //
  //   if (response.statusCode == 200) {
  //     final responseBody = await response.stream.transform(utf8.decoder).join();
  //     return ProfileUpdateImageResponse.fromJson(jsonDecode(responseBody));
  //   } else {
  //     throw Exception('Failed to update profile image: ${response.statusCode}');
  //   }
  // }

   Future<ProfileUpdateImageResponse> updateProfileImage({
    required String imagePath,
    required String filename,
  }) async {
    Uri url = Uri.parse(AppApiEndPoints.updateProfileImage);

    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = "Bearer $accessToken"
      ..fields['filename'] = filename;

    var mimeType = lookupMimeType(imagePath)?.split('/') ?? ['image', 'jpeg'];
    var imageFile = await http.MultipartFile.fromPath(
      'image',
      imagePath,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    request.files.add(imageFile);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return ProfileUpdateImageResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update profile image');
    }
  }




}
