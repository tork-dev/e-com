import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../model/review_response_model.dart';
import '../model/review_submit_response.dart';

class ReviewRepositories{

  final userId = AppLocalStorage().readData(LocalStorageKeys.userId);
  final accessToke = AppLocalStorage().readData(LocalStorageKeys.accessToken);

  Future<ReviewResponse> getReviewResponse({required String productId, required int pageNumber}) async {
    Uri url = Uri.parse("${AppApiEndPoints.productReview}/$productId?page=$pageNumber");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToke",
        "Content-Type": "application/json",
        "type": "app"
      },
    );
    debugPrint("Review Response: ${response.body}");
    return ReviewResponse.fromJson(jsonDecode(response.body));
  }

  Future<ReviewSubmitResponse> getReviewSubmitResponse({required String productId,
    required int rating,
    required String comment,
    required guestUserName,}) async {
    var postBody = jsonEncode({
      "product_id": productId,
      "rating": "$rating",
      "comment": comment,
      "name": "$guestUserName",
    });

    Uri url = Uri.parse(AppApiEndPoints.submitReview);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToke",
        },
        body: postBody);

    return reviewSubmitResponseFromJson(response.body);
  }
}