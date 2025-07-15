// import 'package:http/http.dart' as http;
// import '../../../../utils/constants/app_api_end_points.dart';
// import '../../../utils/constants/app_api_end_points.dart';
// import '../model/blog_categories.dart';
// import '../model/blog_response.dart';
// import '../model/blog_tags_response.dart';
//
// class BlogsRepository {
//   Future<BlogsResponse> getBlogsResponse(
//       {String? search, String? categoryTitle, String? tags, int? pageNumber}) async {
//     if(categoryTitle == 'All'){
//       categoryTitle = '';
//     }
//     Map<dynamic, dynamic> parameters = {
//       'search': search,
//       'blog_category_title': categoryTitle,
//       'tags': tags,
//       'page' : pageNumber
//     };
//
//     String queryString = parameters.entries
//         .map((entry) =>
//             '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
//         .join('&');
//
//     Uri url = Uri.parse("${AppApiEndPoints.blogs}?$queryString");
//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "*/*",
//         "Content-Type": "application/json",
//       },
//     );
//     print(response.body.toString());
//
//     return BlogsResponse.fromJson(response.body.toString());
//   }
//
//   Future<BlogCategories> getBlogsCategories() async {
//     Uri url = Uri.parse(AppApiEndPoints.blogsCategories);
//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "*/*",
//         "Content-Type": "application/json",
//       },
//     );
//     print(response.body.toString());
//
//     return BlogCategories.fromJson(response.body.toString());
//   }
//
//   Future<BlogTags> getBlogsTags() async {
//     Uri url = Uri.parse(AppApiEndPoints.blogsTags);
//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "*/*",
//         "Content-Type": "application/json",
//       },
//     );
//     print(response.body.toString());
//
//     return BlogTags.fromJson(response.body.toString());
//   }
// }
