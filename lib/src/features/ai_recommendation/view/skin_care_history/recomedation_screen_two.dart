import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/ai_recommendation/controller/recommendation_controller.dart';
import 'package:torganic/src/features/ai_recommendation/view/skin_care_history/recomedation_screen_three.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../question_and_value.dart';
import '../widgets/button_row.dart';
import '../widgets/circular_progress_section.dart';
import '../widgets/linear_progress_section.dart';
import '../widgets/radio_question_widget.dart';

class SkinCareHistoryTwo extends StatelessWidget {
  const SkinCareHistoryTwo({super.key});

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
                    circlePercent: 2/9,
                    isNotActive: false,
                  ),
                  Image.asset(
                    AppImages.forwardArrow,
                    width: 25,
                  ),
                  const CircularProgressSection(
                    title: '2. Skincare Goal',
                    circlePercent: 0,
                  )
                ],
              ),
            ),
            const Gap(AppSizes.md),
            const LinearProgressSection(
              linearPercent: 2/9,
              linearPercentString: '2/9',
            ),
            const Gap(AppSizes.md),
            RadioQuestionWidget(
              question: QuestionAndValues().recommendationQuestionAndAns[
                  "skincare_history_questions"]["questions"][1]["question"],
              option: QuestionAndValues().recommendationQuestionAndAns[
                  "skincare_history_questions"]["questions"][1]["options"],
            ),
            const Gap(AppSizes.md),
            ButtonRow(
              onTapNext: (){
                recommendationController.selectedGender = String.fromCharCode(65 + recommendationController.radioButtonSelectedValue.value).toLowerCase();
                print(recommendationController.selectedGender);
                Get.to(()=> const SkinCareHistoryThree());
                recommendationController.setRadioButtonValue(0);
              },
            )
          ],
        ));
  }
}


