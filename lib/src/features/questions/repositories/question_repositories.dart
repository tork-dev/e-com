import 'dart:convert';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:http/http.dart' as http;
import '../model/question_submit_model.dart';
import '../model/questions_model.dart';

class QuestionRepositories{
  static Future<QuestionsResponse> getQuestionResponse({required int productId, page = 1}) async {
    Uri url =
    Uri.parse("${AppApiEndPoints.productQuestions}$productId");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    return questionsResponseFromJson(response.body);
  }

  static Future<QuestionSubmitResponse> getQuestionSubmitResponse({
    required int productId,
    required String name,
    required String question,
  }) async {
    var postBody = jsonEncode(
        {"product_id": productId, "name": name, "text": question});

    Uri url = Uri.parse(AppApiEndPoints.submitQuestion);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: postBody);

    return questionSubmitResponseFromJson(response.body);
  }
}