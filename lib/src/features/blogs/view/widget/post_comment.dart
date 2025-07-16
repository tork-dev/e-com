// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../../../../l10n/app_localizations.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../settings/controller/theme_controller.dart';
//
//
// class PostComment extends StatelessWidget {
//   const PostComment({super.key, required this.onTextFieldTap, required this.onSendButtonPress, required this.textFileFocusNode, required this.commentController});
//
//   final VoidCallback onTextFieldTap, onSendButtonPress;
//   final FocusNode textFileFocusNode;
//   final TextEditingController commentController;
//
//   @override
//   Widget build(BuildContext context) {
//     final themeController = ThemeController.instance;
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//       decoration: BoxDecoration(
//         color: !themeController.isDarkMode.value? AppColors.white : AppColors.dark,
//         border: const Border(
//           top: BorderSide(color: AppColors.accent, width: 1.0),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               onTap: onTextFieldTap,
//               focusNode: textFileFocusNode,
//               controller: commentController,
//               decoration: InputDecoration(
//                 hintText: AppLocalizations.of(context)!.writeAComment,
//                 hintStyle: Theme.of(context).textTheme.labelMedium,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               ),
//               onChanged: (value){
//                 print('print ${commentController.text}');
//               },
//             ),
//           ),
//           const Gap(10),
//           IconButton(
//             icon: const Icon(Icons.send, color: AppColors.primaryColor),
//             onPressed: onSendButtonPress
//           ),
//         ],
//       ),
//     );
//   }
// }