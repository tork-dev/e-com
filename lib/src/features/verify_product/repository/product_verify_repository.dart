import 'dart:convert';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../model/product_verify_list_model.dart';
import 'package:http/http.dart' as http;

class ProductVerifyRepository{

  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);

  Future<ProductVerifyListResponse> getVerifyProductList(int pageNumber) async{
    Uri uri = Uri.parse("${AppApiEndPoints.productVerifyList}?page=$pageNumber&source=app");
    final response = await http.get(uri, headers: {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json"
    });
    if (response.statusCode == 200) {
      return ProductVerifyListResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> submitFeedback({
    required int productID,
    required int orderId,
    required int isAuthentic,
    String? note,
  }) async {
    print("calling from repo");
    final response = await http.post(
      Uri.parse(AppApiEndPoints.submitFeedback),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "source" : "app",
        "product_id": productID,
        "order_id": orderId.toString(),
        "is_authentic": isAuthentic,
        "description": note,
      }),
    );
  }
}