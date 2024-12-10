import 'dart:convert';
import 'dart:io';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../controller/community_comment_controller.dart';
import '../model/community_comment_response.dart';
import '../model/community_like_create_response.dart';
import '../model/community_response.dart';
import '../model/create_community_post_response.dart';

class CommunityRepositories{

  final dynamic accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);

  Future<CommunityResponse> getCommunityPost()async{
    Uri url = Uri.parse(AppApiEndPoints.communityPost);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
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


  Future<AddCommunityLike> getCommunityLikeCreateResponse(
      String postId) async {
    var postBody = jsonEncode({"post_id": postId});

    Uri url = Uri.parse(AppApiEndPoints.createCommunityLike);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);
    print(url);
    print(response.body.toString());
    return addCommunityLikeFromJson(response.body);
  }


  Future<CommunityCommentResponse> getCommunityComment(int postId) async {
    Uri url = Uri.parse("${AppApiEndPoints.communityCommentList}/$postId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return CommunityCommentResponse.fromJson(responseBody);
    }else{
      throw ' Not Working';
    }
  }

  Future<NewCommunityPostResponse> getCommunityCommentCreateResponse(
      String comment,
      int postId,
      ) async {
    var postBody = jsonEncode({
      "comment": comment,
      "post_id": postId,
      "customer_id": "${AppLocalStorage().readData(LocalStorageKeys.userId)}",
      // "parent_id": "$parent_id"
    });

    Uri url = Uri.parse(AppApiEndPoints.communityCommentCreate);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    print(url);
    print(response.body.toString());
    return newCommunityPostResponseFromJson(response.body);
  }
}

