import 'dart:convert';
import 'dart:io';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/logging/logger.dart';
import '../model/community_comment_response.dart';
import '../model/community_like_create_response.dart';
import '../model/community_response.dart';
import '../model/create_community_post_response.dart';

class CommunityRepositories{

  final dynamic accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);

  Future<CommunityResponse> getCommunityPost(int pageNumber)async{
    Uri url = Uri.parse("${AppApiEndPoints.communityPost}?page=$pageNumber?source=app");
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
    File? imageFile, // Now non-required, nullable
    required String filename, // Can be retained or modified as optional if needed
    required String description,
  }) async {
    // Define the endpoint URL
    Uri url = Uri.parse(AppApiEndPoints.createCommunityPost); // Replace with your actual endpoint URL

    // Create the multipart request
    var request = http.MultipartRequest('POST', url);

    // Conditionally add the file if it exists
    if (imageFile != null && imageFile.path.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'banner', // Field name
          imageFile.path,
          filename: filename,
        ),
      );
    }

    // Add other fields to the request
    request.fields['description'] = description;
    request.fields['type'] = 'app';

    // Add headers to the request
    request.headers.addAll({
      "Authorization": "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}",
    });

    try {
      // Send the request and get the response
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        Log.d("Post created successfully: $responseBody");
        return newCommunityPostResponseFromJson(responseBody);
      } else {
        Log.d("Post creation failed with status: ${response.statusCode}");
        throw Exception('Failed to create post');
      }
    } catch (e) {
      Log.d("Exception occurred: $e");
      rethrow;
    }
  }



  Future<AddCommunityLike> getCommunityLikeCreateResponse(
      String postId) async {
    var postBody = jsonEncode({"source" : "app", "post_id": postId});

    Uri url = Uri.parse(AppApiEndPoints.createCommunityLike);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);
    Log.d(url.toString());
    Log.d(response.body.toString());
    return addCommunityLikeFromJson(response.body);
  }


  Future<CommunityCommentResponse> getCommunityComment(int postId) async {
    Uri url = Uri.parse("${AppApiEndPoints.communityCommentList}/$postId?source=app");
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
      "source" : "app",
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

    Log.d(url.toString());
    Log.d(response.body.toString());
    return newCommunityPostResponseFromJson(response.body);
  }
}

