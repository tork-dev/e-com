import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/features/home/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../model/products_response.dart';
import '../question_and_value.dart';
import '../question_model.dart';

class RecommendationController extends GetxController{
  static RecommendationController get instance => Get.find();



  // final RecommendationQuestionAndAns questions = ;

  TextEditingController ageController = TextEditingController();
  Rxn<int> radioButtonSelectedValue = Rxn<int>();
  RxList checkboxSelectedValues = <int>[].obs;
  RxBool apiHitting = true.obs;
 // int get radioButtonSelectedValue => _radioButtonSelectedValue;
  Rx<RecommendationProductResponse> productResponse = RecommendationProductResponse().obs;



  setRadioButtonValue(int? value){
    radioButtonSelectedValue.value = value;

  }
  resetValues(){
    radioButtonSelectedValue.value = null;
    checkboxSelectedValues.value = <int>[];
    ageController.clear();
  }

  void toggleCheckboxValue(int index) {
    if (checkboxSelectedValues.contains(index)) {
      checkboxSelectedValues.remove(index);
    } else {
      checkboxSelectedValues.add(index);
    }
  }

  // double skinHistoryProgress = 1 / 10;
  // double skinGoalProgress = 0;
  // int progressValue = 1;
  // double maximumProgressValue = 10;
  // int questionIndex = 0;

  /// Skin Care History
  String selectedAge = '';
  String selectedGender = '';
  String selectedAlergy = '';
  String selectedPregnant = '';
  String selectedRational = '';
  String selectedBasicSkinCare = '';
  List selectedFollowingSkinCare = [];
  String selectedSkinSensitive = '';
  String selectedSkinBurning = '';



  /// Skin Care Goal
  List skinCareConcern = [];
  String selectedSkinType = '';
  String morningFeel = '';
  String afterShower  = '';
  String afterMoisturizer = '';
  String selectedDamaged = '';


  ///Acne
  String acneOneSelected = '';
  String acneTwoSelected = '';
  String acneThreeSelected = '';
  String acneFourSelected = '';
  String acneFiveSelected = '';

  /// Anti-Aging
  String agingOneSelected = '';
  String agingTwoSelected = '';

  ///BlackHeads
  String blackHeadsOneSelected = '';
  String blackHeadsTwoSelected = '';
  String blackHeadsThreeSelected = '';

  ///Hypigmentation
  String pigmentationOneSelected = '';
  List pigmentationTwoSelected = [];
  List pigmentationThreeSelected = [];


  ///Dullness
  String dullnessOneSelected = '';

  /// Dehydred
  String dehydredOneSelected = '';
  String dehydredTwoSelected = '';



  Future<void> onRefresh()async {
    sendData();
  }


  Map<String, dynamic> formatDataToJson() {
    return {
      "gaip_user_id": AppLocalStorage().readData(LocalStorageKeys.gaipUserId).toString(),
      "member_id" : AppLocalStorage().readData(LocalStorageKeys.userEmail).toString(),
      "questions": {
        "skincare_history": {
          "q1": selectedAge,
          "q2": selectedGender,
          "q3": selectedAlergy,
          "q4": selectedPregnant,
          "q5": selectedRational,
          "q6": selectedBasicSkinCare,
          "q7": selectedFollowingSkinCare,
        },
        "sensitivity_related": {
          "q8": selectedSkinSensitive,
          "q9": selectedSkinBurning,
        },
        "skincare_goal": {
          "q1": skinCareConcern,
          "q2": selectedSkinType,
          "q3": morningFeel,
          "q4": afterShower,
          "q5": afterMoisturizer,
          "q6": selectedDamaged,
        },
        "acne_targeting_questions": {
          "q1": acneOneSelected,
          "q2": acneTwoSelected,
          "q3": acneThreeSelected,
          "q4": acneFourSelected,
          "q5": acneFiveSelected,
        },
        "anti_aging_related": {
          "q1": agingOneSelected,
          "q2": agingTwoSelected,
        },
        "closed_comedones_blackheads_whiteheads_related_questions": {
          "q3": blackHeadsOneSelected,
          "q4": blackHeadsTwoSelected,
        },
        "hyperpigmentation_and_dark_spots_related_questions": {
          "q5": pigmentationOneSelected,
          "q6": pigmentationTwoSelected,
          "q7": pigmentationThreeSelected,
        },
        "dullness_related_questions": {
          "q8": dullnessOneSelected,
        },
        "dehydrated_skin_related_questions": {
          "q9": dehydredOneSelected,
          "q10": dehydredTwoSelected,
        },
      },
      "order_by": "default",
      "per_page": 24,
      "page": 1
    };
  }




  Future<RecommendationProductResponse> sendData() async {
    apiHitting.value = true;
    // Replace this with your API endpoint

    // Create the formatted data
    Map<String, dynamic> formattedData = formatDataToJson();

    // Send the POST request
    final response = await http.post(
      Uri.parse(AppApiEndPoints.recommendationQuestion),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}",
      },
      body: jsonEncode(formattedData),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      var responseData = jsonDecode(response.body);
      print('Response data: $responseData');
      apiHitting.value = false;
      return productResponse.value =  RecommendationProductResponse.fromJson(jsonDecode(response.body));
    } else {
      apiHitting.value = false;
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to send data');
    }
  }

}