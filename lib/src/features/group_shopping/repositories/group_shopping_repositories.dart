import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kirei/src/features/group_shopping/model/group_shopping_groups.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';

import '../model/group_shopping_products_model.dart';

class GroupShoppingRepo{

  Future<GroupShoppingProductsResponse> getGroupShoppingProducts() async{
    final response = await http.get(Uri.parse(AppApiEndPoints.groupShoppingProducts));

    if(response.statusCode == 200){
      return GroupShoppingProductsResponse.fromJson(response.body);
    }else{
      throw 'fetching issue';
    }
  }

  Future<GroupShoppingGroupsResponse> getGroupShoppingGroups() async{
    final response = await http.get(Uri.parse(AppApiEndPoints.shoppingGroups));

    if(response.statusCode == 200){
      return GroupShoppingGroupsResponse.fromJson(response.body);
    }else{
      throw 'fetching issue';
    }
  }

}