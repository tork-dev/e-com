import 'dart:convert';
import 'package:kirei/src/features/wishlist/model/wish_list_add_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:http/http.dart' as http;
import '../../../utils/logging/logger.dart';
import '../model/wishlist_model.dart';
import '../model/wishlist_remove_model.dart';

class WishlistRepositories {
  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);


  Future<WishListAddResponse> addToWishList({required int productId}) async {
    Uri url = Uri.parse(
        "${AppApiEndPoints.addWishlistProduct}$productId");

    Log.d(url.toString());
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    return WishListAddResponse.fromJson(jsonDecode(response.body));
  }

  Future<WishListAddResponse> isProductInUserWishList(
      {required int productId}) async {
    Uri url = Uri.parse(
        "${AppApiEndPoints.checkWishlistProduct}$productId");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );
    Log.d(response.body);
    return WishListAddResponse.fromJson(jsonDecode(response.body));
  }

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


  Future<WishListAddResponse> removeResponse(int id) async {
    final response = await http.get(Uri.parse('${AppApiEndPoints.removeWishlistProduct}$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        });
    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return WishListAddResponse.fromJson(responseBody);
    }else{
      throw Error();
    }
  }
}
