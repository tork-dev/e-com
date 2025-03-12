import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/ai_recommendation/controller/recommendation_controller.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_history/recomedation_screen_five.dart';
import 'package:kirei/src/features/ai_recommendation/view/skin_care_history/recomedation_screen_four.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/logging/logger.dart';
import '../widgets/button_row.dart';
import '../widgets/circular_progress_section.dart';
import '../widgets/linear_progress_section.dart';

class SkinCareHistoryThree extends StatelessWidget {
  const SkinCareHistoryThree({super.key});

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
                    circlePercent: 3/9,
                    isNotActive: false,
                  ),
                  Image.asset(
                    AppImages.forwardArrowIcon,
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
              linearPercent: 3/9,
              linearPercentString: '3/9',
            ),
            const Gap(AppSizes.md),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Center(
                  child: Text( 'Are you allergic to any kind of ingredients?',
                    style: Theme.of(context).textTheme.headlineMedium),
                  )),
            const Gap(AppSizes.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: recommendationController.ageController,
                // onChanged: (value){
                //   print('age' +ageController.text);
                // },
                decoration: InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.grey[350]!, width: 2)
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.grey[350]!, width: 2)
                  ),
                ),
              ),
            ),
            const Gap(AppSizes.md),
            ButtonRow(
              onTapNext: (){
                recommendationController.selectedAlergy.value = recommendationController.ageController.text.toLowerCase();
                Log.d(recommendationController.selectedAlergy.toString());
                if(recommendationController.selectedGender.value == 'a'){
                  Get.to(()=> const SkinCareHistoryFive());
                  return;
                }
                Get.to(()=> const SkinCareHistoryFour());
                recommendationController.resetValues();
              },
            )
          ],
        ));
  }
}


