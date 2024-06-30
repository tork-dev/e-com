import 'dart:convert';
import 'dart:io';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../model/community_response.dart';
import '../model/create_community_post_response.dart';

class CommunityRepositories{

  Future<CommunityResponse> getCommunityPost()async{
    Uri url = Uri.parse(AppApiEndPoints.communityPost);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "type": "app"
      },
    );
    return CommunityResponse.fromJson(jsonDecode(response.body));
  }

  Future<NewCommunityPostResponse> getNewCommunityPostResponse({
    required File imageFile,
    required String filename,
    required String description,
  }) async {
    // Ensure the file exists
    if (!imageFile.existsSync()) {
      print("File does not exist");
      throw Exception("File does not exist");
    }

    // Define the endpoint URL
    Uri url = Uri.parse(AppApiEndPoints.createCommunityPost); // Replace with your actual endpoint URL

    // Create the multipart request
    var request = http.MultipartRequest('POST', url);

    // Add the file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'banner', // The name of the field in the request, should match the expected field name on server
        imageFile.path,
        filename: filename,
      ),
    );

    // Add other fields to the request
    request.fields['description'] = description;
    request.fields['type'] = 'app';

    // Add headers to the request
    request.headers.addAll({
      "Authorization": "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}", // Replace with your actual access token
    });

    try {
      // Send the request and get the response
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print("Image uploaded successfully: $responseBody");
        return newCommunityPostResponseFromJson(responseBody);
      } else {
        print("Image upload failed with status: ${response.statusCode}");
        throw Exception('Failed to create post');
      }
    } catch (e) {
      print("Exception occurred: $e");
      throw e;
    }
  }
}

