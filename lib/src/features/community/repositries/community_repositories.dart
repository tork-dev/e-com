import 'dart:convert';
import 'package:torganic/src/utils/constants/app_api_end_points.dart';
import 'package:http/http.dart' as http;
import '../model/community_response.dart';

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
}