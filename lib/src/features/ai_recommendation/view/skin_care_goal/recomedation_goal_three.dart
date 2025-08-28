// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
// import 'package:kirei/src/common/widgets/containers/card_container.dart';
// import 'package:kirei/src/features/ai_recommendation/controller/recommendation_controller.dart';
// import 'package:kirei/src/features/ai_recommendation/view/skin_care_goal/recomedation_goal_four.dart';
// import 'package:kirei/src/utils/constants/colors.dart';
// import 'package:kirei/src/utils/constants/sizes.dart';
// import '../../../../utils/constants/image_strings.dart';
// import '../../../../utils/logging/logger.dart';
// import '../../question_and_value.dart';
// import '../widgets/button_row.dart';
// import '../widgets/circular_progress_section.dart';
// import '../widgets/linear_progress_section.dart';
// import '../widgets/radio_question_widget.dart';
//
// class RecommendationGoalThree extends StatelessWidget {
//   const RecommendationGoalThree({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     RecommendationController recommendationController =
//         Get.put(RecommendationController());
//     return AppLayoutWithBackButton(
//         bodyBackgroundColor: Colors.grey[100],
//         title: const Text(
//           'AI Suggestion',
//           style: TextStyle(color: AppColors.backLayoutAppBarTitle),
//         ),
//         centerTitle: true,
//         leadingIconColor: AppColors.darkGrey,
//         padding: 0,
//         body: ListView(
//           children: [
//             AppCardContainer(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: AppSizes.sm, vertical: AppSizes.md),
//               applyRadius: false,
//               backgroundColor: AppColors.secondary,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const CircularProgressSection(
//                     title: '1. Skincare History',
//                     circlePercent: 1,
//                     isNotActive: true,
//                     isDone: true,
//                   ),
//                   Image.asset(
//                     AppImages.forwardArrowIcon,
//                     width: 25,
//                   ),
//                   const CircularProgressSection(
//                     title: '2. Skincare Goal',
//                     circlePercent: 3/6,
//                     isNotActive: false,
//                   )
//                 ],
//               ),
//             ),
//             const Gap(AppSizes.md),
//             const LinearProgressSection(
//               linearPercent: 3/6,
//               linearPercentString: '3/6',
//             ),
//             const Gap(AppSizes.md),
//             RadioQuestionWidget(
//               question: QuestionAndValues().recommendationQuestionAndAns[
//                   "skincare_goal_questions"]["questions"][2]["question"],
//               option: QuestionAndValues().recommendationQuestionAndAns[
//                   "skincare_goal_questions"]["questions"][2]["options"],
//             ),
//             const Gap(AppSizes.md),
//             ButtonRow(
//               onTapNext: (){
//                 recommendationController.morningFeel.value = String.fromCharCode(65 + recommendationController.radioButtonSelectedValue.value!).toLowerCase();
//                 Log.d(recommendationController.morningFeel.toString());
//                 Get.to(()=> const RecommendationGoalFour());
//                 recommendationController.resetValues();
//               },
//             )
//           ],
//         ));
//   }
// }
//
//
