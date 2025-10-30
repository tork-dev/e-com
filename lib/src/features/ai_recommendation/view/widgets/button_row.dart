// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kirei/src/utils/constants/colors.dart';
// import 'package:kirei/src/utils/helpers/helper_functions.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../controller/recommendation_controller.dart';
//
// class ButtonRow extends StatelessWidget {
//   final VoidCallback onTapNext;
//
//   const ButtonRow({
//     super.key, required this.onTapNext,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final recommendationController = Get.put(RecommendationController());
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             width: 100,
//             child: InkWell(
//               onTap: () {
//                 Get.back();
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 height: 50,
//                 width: 120,
//                 color: AppColors.white,
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.arrow_back_ios_new_rounded,
//                       size: 16,
//                       color: AppColors.secondary,
//                     ),
//                     SizedBox(
//                       width: 12,
//                     ),
//                     Text(
//                       'BACK',
//                       style: TextStyle(
//                           color: AppColors.secondary,
//                           fontWeight: FontWeight.bold),
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 100,
//             child: InkWell(
//               onTap: () {
//                 if (recommendationController.radioButtonSelectedValue.value ==
//                     null &&
//                     recommendationController.checkboxSelectedValues.isEmpty &&
//                    recommendationController.ageController.text == '') {
//                   AppHelperFunctions.showToast('Please select an answer');
//                   return;
//                 }
//                 onTapNext();
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 height: 50,
//                 width: 120,
//                 color: AppColors.secondary,
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'NEXT',
//                       style: TextStyle(
//                           color: AppColors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       width: 12,
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 16,
//                       color: AppColors.white,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }