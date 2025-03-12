import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/questions/model/questions_model.dart';
import 'package:kirei/src/features/questions/repositories/question_repositories.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/logging/logger.dart';
import '../model/question_submit_model.dart';

class QuestionController extends GetxController {

  final int productId;

  QuestionController({required this.productId});

  static QuestionController get instance => Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController questionController = TextEditingController();

  Rx<QuestionsResponse> questionResponse = QuestionsResponse().obs;
  Rx<QuestionSubmitResponse> questionSubmitResponse = QuestionSubmitResponse()
      .obs;

  RxBool apiHitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    apiHitting.value = true;
    await getQuestionResponse();
    apiHitting.value = false;
  }

  Future<QuestionsResponse> getQuestionResponse() async {
    return questionResponse.value =
    await QuestionRepositories.getQuestionResponse(productId: productId);
  }

  Future<void> submitQuestion() async {
    if(nameController.text == ''){
      AppHelperFunctions.showToast('Please enter your name');
      return;
    }
    if(questionController.text == ''){
      AppHelperFunctions.showToast('Please enter a question');
      return;
    }
    try {
      apiHitting.value = true;
      questionSubmitResponse.value =
      await QuestionRepositories.getQuestionSubmitResponse(
          productId: productId, name: nameController.text, question: questionController.text);
      apiHitting.value = false;
      nameController.text = '';
      questionController.text = '';
      AppHelperFunctions.showToast(questionSubmitResponse.value.message!);
    } catch (e) {
      Log.d(e.toString());
    }
  }
}