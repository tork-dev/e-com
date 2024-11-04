import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/ai_recommendation/controller/recommendation_controller.dart';
import 'package:kirei/src/features/ai_recommendation/view/recommended_products.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/acne/recomedation_acne_two.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/anti_aging/recomedation_anti_aging_one.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/recomedation_goal_five.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../question_and_value.dart';
import '../../widgets/button_row.dart';
import '../../widgets/circular_progress_section.dart';
import '../../widgets/linear_progress_section.dart';
import '../../widgets/radio_question_widget.dart';

class RecommendationAcneFive extends StatelessWidget {
  const RecommendationAcneFive({super.key});

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
                    circlePercent: 5/5,
                    isNotActive: false,
                  )
                ],
              ),
            ),
            const Gap(AppSizes.md),
            const LinearProgressSection(
              linearPercent: 5/5,
              linearPercentString: '5/5',
            ),
            const Gap(AppSizes.md),
            RadioQuestionWidget(
              question: QuestionAndValues().recommendationQuestionAndAns[
                  "related_questions_based_on_primary_concern"]["acne"]["questions"][4]["question"],
              option: QuestionAndValues().recommendationQuestionAndAns[
                  "related_questions_based_on_primary_concern"]["acne"]["questions"][4]["options"],
            ),
            const Gap(AppSizes.md),
            ButtonRow(
              onTapNext: (){
                recommendationController.acneFiveSelected = String.fromCharCode(65 + recommendationController.radioButtonSelectedValue.value!).toLowerCase();
                print(recommendationController.acneFiveSelected);
                recommendationController.sendData();
                recommendationController.resetValues();
                Get.toNamed('/recommended-products');
              },
            )
          ],
        ));
  }
}


