// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:kirei/src/utils/constants/colors.dart';
// import 'package:kirei/src/utils/constants/sizes.dart';
// import 'package:kirei/src/utils/helpers/helper_functions.dart';
//
// class AppAnimationLoader extends StatelessWidget {
//   const AppAnimationLoader({super.key,
//     required this.animation,
//     required this.text,
//     this.showAction = false,
//     this.actionText,
//     this.onActionPressed});
//
//   final String animation, text;
//   final bool showAction;
//   final String? actionText;
//   final VoidCallback? onActionPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Lottie.asset(animation,
//               width: AppHelperFunctions.screenWidth() * 0.8),
//           const Gap(AppSizes.defaultSpace),
//           Text(
//             text,
//             style: Theme
//                 .of(context)
//                 .textTheme
//                 .bodyMedium,
//             textAlign: TextAlign.center,
//           ),
//           const Gap(AppSizes.defaultSpace),
//           showAction ? SizedBox(
//             width: 250,
//             child: OutlinedButton(
//               onPressed: onActionPressed,
//               style: OutlinedButton.styleFrom(backgroundColor: AppColors.dark),
//               child: Text(
//                 actionText!,
//                 style: Theme
//                     .of(context)
//                     .textTheme
//                     .bodyMedium!
//                     .apply(color: AppColors.light),
//               ),
//             ),
//           ) : const SizedBox()
//         ],
//       ),
//     );
//   }
// }
