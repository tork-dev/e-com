import 'dart:convert';

import 'package:torganic/src/utils/constants/app_api_end_points.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';
import 'package:http/http.dart' as http;
import '../model/wishlist_model.dart';
import '../model/wishlist_remove_model.dart';

class WishlistRepositories {
  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);

  Future<WishlistResponse> getWishlistProduct() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.wishlistProducts),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        });

    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return WishlistResponse.fromJson(responseBody);
    }else{
      throw Error();
    }
  }

  Future<WishlistRemoveResponse> deleteFromWishlist(int id) async {
    final response = await http.delete(Uri.parse('${AppApiEndPoints.wishlistProducts}/$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        });
    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return WishlistRemoveResponse.fromJson(responseBody);
    }else{
      throw Error();
    }
  }
}
