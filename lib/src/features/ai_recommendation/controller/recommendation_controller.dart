import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../model/products_response.dart';

class RecommendationController extends GetxController{
  static RecommendationController get instance => Get.find();



  // final RecommendationQuestionAndAns questions = ;

  TextEditingController ageController = TextEditingController();
  Rxn<int> radioButtonSelectedValue = Rxn<int>();
  RxList checkboxSelectedValues = <int>[].obs;
  RxBool apiHitting = true.obs;
  Rx<RecommendationProductResponse> productResponse = RecommendationProductResponse().obs;
  RxString queryValue = ''.obs;



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
    buildQueryParams();
    // Create the formatted data
    Map<String, dynamic> formattedData = formatDataToJson();
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



  String buildQueryParams() {
    Map<String, dynamic> queryParams = {};

    queryParams.addAll({
      "skincare_history_q1": selectedAge,
      "skincare_history_q2": selectedGender,
      "skincare_history_q3": selectedAlergy,
      "skincare_history_q4": selectedPregnant,
      "skincare_history_q5": selectedRational,
      "skincare_history_q6": selectedBasicSkinCare,
      "skincare_history_q7": selectedFollowingSkinCare.join(","),
      "sensitivity_related_q8": selectedSkinSensitive,
      "sensitivity_related_q9": selectedSkinBurning,
      "skincare_goal_q1": skinCareConcern.join(","),
      "skincare_goal_q2": selectedSkinType,
      "skincare_goal_q3": morningFeel,
      "skincare_goal_q4": afterShower,
      "skincare_goal_q5": afterMoisturizer,
      "skincare_goal_q6": selectedDamaged,
      "acne_targeting_questions_q1": acneOneSelected,
      "acne_targeting_questions_q2": acneTwoSelected,
      "acne_targeting_questions_q3": acneThreeSelected,
      "acne_targeting_questions_q4": acneFourSelected,
      "acne_targeting_questions_q5": acneFiveSelected,
      "anti_aging_related_q1": agingOneSelected,
      "anti_aging_related_q2": agingTwoSelected,
      "closed_comedones_blackheads_whiteheads_related_questions_q3": blackHeadsOneSelected,
      "closed_comedones_blackheads_whiteheads_related_questions_q4": blackHeadsTwoSelected,
      "hyperpigmentation_and_dark_spots_related_questions_q5": pigmentationOneSelected,
      "hyperpigmentation_and_dark_spots_related_questions_q6": pigmentationTwoSelected.join(","),
      "hyperpigmentation_and_dark_spots_related_questions_q7": pigmentationThreeSelected.join(","),
      "dullness_related_questions_q8": dullnessOneSelected,
      "dehydrated_skin_related_questions_q9": dehydredOneSelected,
      "dehydrated_skin_related_questions_q10": dehydredTwoSelected,
    });

    print(Uri(queryParameters: queryParams).query);
    return Uri(queryParameters: queryParams).query;
  }



  void extractValuesFromUrl(String url) {
    final uri = Uri.parse(url); // Parse the URL
    final queryParams = uri.queryParameters; // Extract query parameters

    // Extract and assign values
    selectedAge = queryParams['skincare_history_q1'] ?? '';
    selectedGender = queryParams['skincare_history_q2'] ?? '';
    selectedAlergy = queryParams['skincare_history_q3'] ?? '';
    selectedPregnant = queryParams['skincare_history_q4'] ?? '';
    selectedRational = queryParams['skincare_history_q5'] ?? '';
    selectedBasicSkinCare = queryParams['skincare_history_q6'] ?? '';
    selectedFollowingSkinCare = queryParams['skincare_history_q7']?.split(',') ?? [];
    selectedSkinSensitive = queryParams['sensitivity_related_q8'] ?? '';
    selectedSkinBurning = queryParams['sensitivity_related_q9'] ?? '';

    skinCareConcern = queryParams['skincare_goal_q1']?.split(',') ?? [];
    selectedSkinType = queryParams['skincare_goal_q2'] ?? '';
    morningFeel = queryParams['skincare_goal_q3'] ?? '';
    afterShower = queryParams['skincare_goal_q4'] ?? '';
    afterMoisturizer = queryParams['skincare_goal_q5'] ?? '';
    selectedDamaged = queryParams['skincare_goal_q6'] ?? '';

    acneOneSelected = queryParams['acne_targeting_q1'] ?? '';
    acneTwoSelected = queryParams['acne_targeting_q2'] ?? '';
    acneThreeSelected = queryParams['acne_targeting_q3'] ?? '';
    acneFourSelected = queryParams['acne_targeting_q4'] ?? '';
    acneFiveSelected = queryParams['acne_targeting_q5'] ?? '';

    agingOneSelected = queryParams['anti_aging_q1'] ?? '';
    agingTwoSelected = queryParams['anti_aging_q2'] ?? '';

    blackHeadsOneSelected = queryParams['blackheads_q3'] ?? '';
    blackHeadsTwoSelected = queryParams['blackheads_q4'] ?? '';

    pigmentationOneSelected = queryParams['pigmentation_q5'] ?? '';
    pigmentationTwoSelected = queryParams['pigmentation_q6']?.split(',') ?? [];
    pigmentationThreeSelected = queryParams['pigmentation_q7']?.split(',') ?? [];

    dullnessOneSelected = queryParams['dullness_q8'] ?? '';

    dehydredOneSelected = queryParams['dehydrated_q9'] ?? '';
    dehydredTwoSelected = queryParams['dehydrated_q10'] ?? '';
  }


}