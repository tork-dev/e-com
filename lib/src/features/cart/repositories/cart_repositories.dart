import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:torganic/src/features/cart/model/card_add_response_model.dart';
import 'package:torganic/src/utils/constants/app_api_end_points.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';

class CartRepositories {

  final int userId =  AppLocalStorage().readData(LocalStorageKeys.userId);
  final String version = AppLocalStorage().readData(LocalStorageKeys.appVersion);
  final dynamic accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);


  Future<AddToCartResponse> getCartAddResponse(
    int id,
    //String variant,
    int quantity,
    dynamic preorderAvailable,
  ) async {
    var postBody = jsonEncode({
      "id": id,
      "user_id": userId,
      "quantity": quantity,
      "is_preorder": "$preorderAvailable",
      "version": version,
    });

    print(postBody);

    Uri url = Uri.parse(AppApiEndPoints.addToCart);
    print(url);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    print(response.body.toString());
    return AddToCartResponse.fromJson(jsonDecode(response.body));
  }
}
