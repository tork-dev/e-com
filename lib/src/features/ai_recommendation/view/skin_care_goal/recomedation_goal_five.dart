import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/ai_recommendation/controller/recommendation_controller.dart';
import 'package:torganic/src/features/ai_recommendation/view/skin_care_goal/recomedation_goal_six.dart';
import 'package:torganic/src/features/ai_recommendation/view/skin_care_history/recomedation_screen_seven.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../question_and_value.dart';
import '../widgets/button_row.dart';
import '../widgets/circular_progress_section.dart';
import '../widgets/linear_progress_section.dart';
import '../widgets/radio_question_widget.dart';

class RecommendationGoalFive extends StatelessWidget {
  const RecommendationGoalFive({super.key});

  @override
  Widget build(BuildContext context) {
    RecommendationController recommendationController =
        Get.put(RecommendationController());
    return AppLayoutWithBackButton(
        bodyBackgroundColor: Colors.grey[100],
        title: const Text(
          'Ai Recommended',
          style: TextStyle(color: Colors.blueGrey),
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
                    AppImages.forwardArrow,
                    width: 25,
                  ),
                  const CircularProgressSection(
                    title: '2. Skincare Goal',
                    circlePercent: 5/6,
                    isNotActive: false,
                  )
                ],
              ),
            ),
            const Gap(AppSizes.md),
            const LinearProgressSection(
              linearPercent: 5/6,
              linearPercentString: '5/6',
            ),
            const Gap(AppSizes.md),
            RadioQuestionWidget(
              question: QuestionAndValues().recommendationQuestionAndAns[
                  "skincare_goal_questions"]["questions"][4]["question"],
              option: QuestionAndValues().recommendationQuestionAndAns[
                  "skincare_goal_questions"]["questions"][4]["options"],
            ),
            const Gap(AppSizes.md),
            ButtonRow(
              onTapNext: (){
                recommendationController.afterMoisturizer = String.fromCharCode(65 + recommendationController.radioButtonSelectedValue.value).toLowerCase();
                print(recommendationController.afterMoisturizer);
                Get.to(()=> const RecommendationGoalSix());
                recommendationController.setRadioButtonValue(0);
              },
            )
          ],
        ));
  }
}


