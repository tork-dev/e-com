import 'package:http/http.dart' as http;
import '../../../utils/constants/app_api_end_points.dart';
import '../model/blog_categories.dart';
import '../model/blog_response.dart';
import '../model/blog_tags_response.dart';

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
      'page' : pageNumber
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

  Future<BlogCategories> getBlogsCategories() async {
    Uri url = Uri.parse(AppApiEndPoints.blogCategories);
    final response = await http.get(
      url,
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
      },
    );
    print(response.body.toString());

    return BlogCategories.fromJson(response.body.toString());
  }

  Future<BlogTags> getBlogsTags() async {
    Uri url = Uri.parse(AppApiEndPoints.blogTags);
    final response = await http.get(
      url,
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
      },
    );
    print(response.body.toString());

    return BlogTags.fromJson(response.body.toString());
  }
  //
  // Future<BlogsDetailsResponse> getBlogsDetailsResponse({required String slug}) async {
  //   Uri url = Uri.parse("${AppApiEndPoints.blogsDetails}$slug");
  //   final response = await http.get(url,
  //     headers: {
  //       "Accept": "*/*",
  //       "Content-Type": "application/json",
  //     },
  //   );
  //   if (kDebugMode) {
  //     print(response.body.toString());
  //   }
  //   return BlogsDetailsResponse.fromJson(response.body.toString());
  // }
  //
  // Future<PostCommentResponse> postComment({required String message, required int blogId, int? parentId}) async{
  //   final response = await http.post(Uri.parse(AppApiEndPoints.postComment), headers: {
  //     'Authorization': 'Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}',
  //     "Accept": "*/*",
  //     "Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "message" : message,
  //         'blog_id' : blogId,
  //         'parent_id' : parentId,
  //         'name' : AppLocalStorage().readData(LocalStorageKeys.userName),
  //         'email' : AppLocalStorage().readData(LocalStorageKeys.userEmail)
  //       })
  //   );
  //   return PostCommentResponse.fromJson(response.body);
  // }

}
