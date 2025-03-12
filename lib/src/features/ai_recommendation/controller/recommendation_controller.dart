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



  TextEditingController ageController = TextEditingController();
  Rxn<int> radioButtonSelectedValue = Rxn<int>();
  RxList checkboxSelectedValues = <int>[].obs;
  RxBool apiHitting = true.obs;
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


  /// Skin Care History
  RxString selectedAge = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedAlergy = ''.obs;
  RxString selectedPregnant = ''.obs;
  RxString selectedRational = ''.obs;
  RxString selectedBasicSkinCare = ''.obs;
  RxList selectedFollowingSkinCare = <dynamic>[].obs;
  RxString selectedSkinSensitive = ''.obs;
  RxString selectedSkinBurning = ''.obs;

  /// Skin Care Goal
  RxList skinCareConcern = <dynamic>[].obs;
  RxString selectedSkinType = ''.obs;
  RxString morningFeel = ''.obs;
  RxString afterShower = ''.obs;
  RxString afterMoisturizer = ''.obs;
  RxString selectedDamaged = ''.obs;

  /// Acne
  RxString acneOneSelected = ''.obs;
  RxString acneTwoSelected = ''.obs;
  RxString acneThreeSelected = ''.obs;
  RxString acneFourSelected = ''.obs;
  RxString acneFiveSelected = ''.obs;

  /// Anti-Aging
  RxString agingOneSelected = ''.obs;
  RxString agingTwoSelected = ''.obs;

  /// BlackHeads
  RxString blackHeadsOneSelected = ''.obs;
  RxString blackHeadsTwoSelected = ''.obs;
  RxString blackHeadsThreeSelected = ''.obs;

  /// Hypigmentation
  RxString pigmentationOneSelected = ''.obs;
  RxList pigmentationTwoSelected = <dynamic>[].obs;
  RxList pigmentationThreeSelected = <dynamic>[].obs;

  /// Dullness
  RxString dullnessOneSelected = ''.obs;

  /// Dehydrated
  RxString dehydredOneSelected = ''.obs;
  RxString dehydredTwoSelected = ''.obs;



  Future<void> onRefresh()async {
    sendData();
  }


  Map<String, dynamic> formatDataToJson() {
    return {
      "gaip_user_id": AppLocalStorage().readData(LocalStorageKeys.gaipUserId).toString(),
      "member_id" : AppLocalStorage().readData(LocalStorageKeys.userEmail).toString(),
      "questions": {
        "skincare_history": {
          "q1": selectedAge.value,
          "q2": selectedGender.value,
          "q3": selectedAlergy.value,
          "q4": selectedPregnant.value,
          "q5": selectedRational.value,
          "q6": selectedBasicSkinCare.value,
          "q7": selectedFollowingSkinCare,
        },
        "sensitivity_related": {
          "q8": selectedSkinSensitive.value,
          "q9": selectedSkinBurning.value,
        },
        "skincare_goal": {
          "q1": skinCareConcern,
          "q2": selectedSkinType.value,
          "q3": morningFeel.value,
          "q4": afterShower.value,
          "q5": afterMoisturizer.value,
          "q6": selectedDamaged.value,
        },
        "acne_targeting_questions": {
          "q1": acneOneSelected.value,
          "q2": acneTwoSelected.value,
          "q3": acneThreeSelected.value,
          "q4": acneFourSelected.value,
          "q5": acneFiveSelected.value,
        },
        "anti_aging_related": {
          "q1": agingOneSelected.value,
          "q2": agingTwoSelected.value,
        },
        "closed_comedones_blackheads_whiteheads_related_questions": {
          "q3": blackHeadsOneSelected.value,
          "q4": blackHeadsTwoSelected.value,
        },
        "hyperpigmentation_and_dark_spots_related_questions": {
          "q5": pigmentationOneSelected.value,
          "q6": pigmentationTwoSelected,
          "q7": pigmentationThreeSelected,
        },
        "dullness_related_questions": {
          "q8": dullnessOneSelected.value,
        },
        "dehydrated_skin_related_questions": {
          "q9": dehydredOneSelected.value,
          "q10": dehydredTwoSelected.value,
        },

      },
      "order_by": "default",
      "per_page": 24,
      "page": 1
    };
  }




  Future<RecommendationProductResponse> sendData() async {
    apiHitting.value = true;
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
      apiHitting.value = false;
      return productResponse.value =  RecommendationProductResponse.fromJson(jsonDecode(response.body));
    } else {
      apiHitting.value = false;
      throw Exception('Failed to send data');
    }
  }



  String buildQueryParams() {
    Map<String, dynamic> queryParams = {};

    queryParams.addAll({
      "skincare_history_q1": selectedAge.value,
      "skincare_history_q2": selectedGender.value,
      "skincare_history_q3": selectedAlergy.value,
      "skincare_history_q4": selectedPregnant.value,
      "skincare_history_q5": selectedRational.value,
      "skincare_history_q6": selectedBasicSkinCare.value,
      "skincare_history_q7": selectedFollowingSkinCare.join(","),
      "sensitivity_related_q8": selectedSkinSensitive.value,
      "sensitivity_related_q9": selectedSkinBurning.value,
      "skincare_goal_q1": skinCareConcern.join(","),
      "skincare_goal_q2": selectedSkinType.value,
      "skincare_goal_q3": morningFeel.value,
      "skincare_goal_q4": afterShower.value,
      "skincare_goal_q5": afterMoisturizer.value,
      "skincare_goal_q6": selectedDamaged.value,
      "acne_targeting_questions_q1": acneOneSelected.value,
      "acne_targeting_questions_q2": acneTwoSelected.value,
      "acne_targeting_questions_q3": acneThreeSelected.value,
      "acne_targeting_questions_q4": acneFourSelected.value,
      "acne_targeting_questions_q5": acneFiveSelected.value,
      "anti_aging_related_q1": agingOneSelected.value,
      "anti_aging_related_q2": agingTwoSelected.value,
      "closed_comedones_blackheads_whiteheads_related_questions_q3": blackHeadsOneSelected.value,
      "closed_comedones_blackheads_whiteheads_related_questions_q4": blackHeadsTwoSelected.value,
      "hyperpigmentation_and_dark_spots_related_questions_q5": pigmentationOneSelected.value,
      "hyperpigmentation_and_dark_spots_related_questions_q6": pigmentationTwoSelected.join(","),
      "hyperpigmentation_and_dark_spots_related_questions_q7": pigmentationThreeSelected.join(","),
      "dullness_related_questions_q8": dullnessOneSelected.value,
      "dehydrated_skin_related_questions_q9": dehydredOneSelected.value,
      "dehydrated_skin_related_questions_q10": dehydredTwoSelected.value,
    });
    return Uri(queryParameters: queryParams).query;
  }



  void extractValuesFromUrl(Uri uri) {
    final queryParams = uri.queryParameters; // Extract query parameters

    // Extract and assign values
    selectedAge.value = queryParams['skincare_history_q1'] ?? '';
    selectedGender.value = queryParams['skincare_history_q2'] ?? '';
    selectedAlergy.value = queryParams['skincare_history_q3'] ?? '';
    selectedPregnant.value = queryParams['skincare_history_q4'] ?? '';
    selectedRational.value = queryParams['skincare_history_q5'] ?? '';
    selectedBasicSkinCare.value = queryParams['skincare_history_q6'] ?? '';
    selectedFollowingSkinCare.value = queryParams['skincare_history_q7']?.split(',') ?? [];
    selectedSkinSensitive.value = queryParams['sensitivity_related_q8'] ?? '';
    selectedSkinBurning.value = queryParams['sensitivity_related_q9'] ?? '';

    skinCareConcern.value = queryParams['skincare_goal_q1']?.split(',') ?? [];
    selectedSkinType.value = queryParams['skincare_goal_q2'] ?? '';
    morningFeel.value = queryParams['skincare_goal_q3'] ?? '';
    afterShower.value = queryParams['skincare_goal_q4'] ?? '';
    afterMoisturizer.value = queryParams['skincare_goal_q5'] ?? '';
    selectedDamaged.value = queryParams['skincare_goal_q6'] ?? '';

    acneOneSelected.value = queryParams['acne_targeting_q1'] ?? '';
    acneTwoSelected.value = queryParams['acne_targeting_q2'] ?? '';
    acneThreeSelected.value = queryParams['acne_targeting_q3'] ?? '';
    acneFourSelected.value = queryParams['acne_targeting_q4'] ?? '';
    acneFiveSelected.value = queryParams['acne_targeting_q5'] ?? '';

    agingOneSelected.value = queryParams['anti_aging_q1'] ?? '';
    agingTwoSelected.value = queryParams['anti_aging_q2'] ?? '';

    blackHeadsOneSelected.value = queryParams['blackheads_q3'] ?? '';
    blackHeadsTwoSelected.value = queryParams['blackheads_q4'] ?? '';

    pigmentationOneSelected.value = queryParams['pigmentation_q5'] ?? '';
    pigmentationTwoSelected.value = queryParams['pigmentation_q6']?.split(',') ?? [];
    pigmentationThreeSelected.value = queryParams['pigmentation_q7']?.split(',') ?? [];

    dullnessOneSelected.value = queryParams['dullness_q8'] ?? '';

    dehydredOneSelected.value = queryParams['dehydrated_q9'] ?? '';
    dehydredTwoSelected.value = queryParams['dehydrated_q10'] ?? '';

  }


}