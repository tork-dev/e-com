import 'dart:convert';
import 'package:torganic/src/utils/constants/app_api_end_points.dart';
import '../model/search_model.dart';
import 'package:http/http.dart' as http;


class SearchRepositories{
  Future <SearchResponse> getSearchResponse(String searchKey) async{
    final response = await http.get(Uri.parse("${AppApiEndPoints.shopProducts}search=$searchKey&gaip_user_id=null"));
    print('///'+response.toString());
    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return SearchResponse.fromJson(responseBody);
    }else{
      throw 'error';
    }
  }
}