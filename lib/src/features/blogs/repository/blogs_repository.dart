import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/blogs/model/blog_details_model.dart';
import 'package:kirei/src/features/blogs/view/widget/post_comment.dart';
import 'package:kirei/src/features/community/model/community_comment_response.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../community/model/create_community_post_response.dart';
import '../model/blog_response.dart';

class BlogsRepository {

  Future<BlogsResponseModel> getBlogsResponse(
      {String? search, String? categoryTitle, String? tags, int? pageNumber}) async {
    if(categoryTitle == 'All'){
      categoryTitle = '';
    }
    Map<dynamic, dynamic> parameters = {
      'search': search,
      'blog_category_title': categoryTitle,
      'tags': tags,
      'page' : pageNumber,
      "source" : "app",
    };

    String queryString = parameters.entries
        .map((entry) =>
            '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');

    Uri url = Uri.parse("${AppApiEndPoints.blogs}?$queryString");
    final response = await http.get(
      url,
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
      },
    );
    print(response.body.toString());

    return BlogsResponseModel.fromJson(response.body.toString());
  }

  Future<BlogDetailsResponseModel> getBlogsDetailsResponse({required String slug}) async {
    Uri url = Uri.parse("${AppApiEndPoints.blogDetails}/$slug?source=app");
    final response = await http.get(url,
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
      },
    );
    if (kDebugMode) {
      print(response.body.toString());
    }
    return BlogDetailsResponseModel.fromJson(response.body.toString());
  }

  Future<NewCommunityPostResponse> postComment({required String message, required int blogId}) async{
    final response = await http.post(Uri.parse(AppApiEndPoints.postBlogComment), headers: {
      'Authorization': 'Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}',
      "Accept": "*/*",
      "Content-Type": "application/json"},
        body: jsonEncode({
          "comment" : message,
          'blog_id' : blogId,
          'name' : AppLocalStorage().readData(LocalStorageKeys.userName),
          'email' : AppLocalStorage().readData(LocalStorageKeys.userEmail)
        })
    );
    return NewCommunityPostResponse.fromJson(jsonDecode(response.body));
  }

}
