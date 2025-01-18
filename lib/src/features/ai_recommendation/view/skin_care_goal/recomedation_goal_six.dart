import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/ai_recommendation/controller/recommendation_controller.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/acne/recomedation_acne_one.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/anti_aging/recomedation_anti_aging_one.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/blackheads/recomedation_black_heads_one.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/dehydration/recomedation_dehydration_one.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/dullness/recomedation_dullness_one.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/hypigmentation/recomedation_pigmentaion_one.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../question_and_value.dart';
import '../widgets/button_row.dart';
import '../widgets/circular_progress_section.dart';
import '../widgets/linear_progress_section.dart';
import '../widgets/radio_question_widget.dart';

class RecommendationGoalSix extends StatelessWidget {
  const RecommendationGoalSix({super.key});

  @override
  Widget build(BuildContext context) {
    RecommendationController recommendationController =
        Get.put(RecommendationController());
    return AppLayoutWithBackButton(
        bodyBackgroundColor: Colors.grey[100],
        title: const Text(
          'AI Suggestion',
          style: TextStyle(color: AppColors.backLayoutAppBarTitle),
        ),
        centerTitle: true,
        leadingIconColor: AppColors.darkGrey,
        padding: 0,
        body: ListView(
          children: [
            AppCardContainer(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.sm, vertical: AppSizes.md),
              applyRadius: false,
              backgroundColor: AppColors.secondary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircularProgressSection(
                    title: '1. Skincare History',
                    circlePercent: 1,
                    isNotActive: true,
                    isDone: true,
                  ),
                  Image.asset(
                    AppImages.forwardArrowIcon,
                    width: 25,
                  ),
                  const CircularProgressSection(
                    title: '2. Skincare Goal',
                    circlePercent: 6/6,
                    isNotActive: false,
                  )
                ],
              ),
            ),
            const Gap(AppSizes.md),
            const LinearProgressSection(
              linearPercent: 6/6,
              linearPercentString: '6/6',
            ),
            const Gap(AppSizes.md),
            RadioQuestionWidget(
              question: QuestionAndValues().recommendationQuestionAndAns[
                  "skincare_goal_questions"]["questions"][5]["question"],
              option: QuestionAndValues().recommendationQuestionAndAns[
                  "skincare_goal_questions"]["questions"][5]["options"],
            ),
            const Gap(AppSizes.md),
            ButtonRow(
              onTapNext: (){
                if(recommendationController.skinCareConcern[0] == 'a'){
                  Get.to(()=> const RecommendationAcneOne());
                }else if(recommendationController.skinCareConcern[0] == 'b'){
                  Get.to(()=> const RecommendationAntiAgingOne());
                }else if(recommendationController.skinCareConcern[0] == 'c'){
                  Get.to(()=> const RecommendationBlackHeadsOne());
                }else if(recommendationController.skinCareConcern[0] == 'd'){
                  Get.to(()=> const RecommendationPigmentationOne());
                }else if(recommendationController.skinCareConcern[0] == 'e'){
                  Get.to(()=> const RecommendationDullnessOne());
                }else if(recommendationController.skinCareConcern[0] == 'f'){
                  Get.to(()=> const RecommendationDehydrationOne());
                }
                recommendationController.selectedDamaged.value = String.fromCharCode(65 + recommendationController.radioButtonSelectedValue.value!).toLowerCase();
                print(recommendationController.selectedDamaged);
                recommendationController.resetValues();
              },
            )
          ],
        ));
  }
}


