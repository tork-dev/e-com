// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import '../../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
// import '../../../../l10n/app_localizations.dart';
// import '../../../../utils/helpers/helper_functions.dart';
// import '../controller/blogs_controller.dart';
// import 'widget/device/mobile_blogs.dart';
//
// class Blogs extends StatefulWidget {
//   const Blogs({super.key});
//
//   @override
//   State<Blogs> createState() => _BlogsState();
// }
//
// class _BlogsState extends State<Blogs> {
//   @override
//   Widget build(BuildContext context) {
//     final blogController = Get.put(BlogsController());
//     final isDark = AppHelperFunctions.isDarkMode(context);
//     return AppLayoutWithBackButton(
//       defaultPadding: false,
//       customPadding: EdgeInsets.zero,
//       title:  Text(
//         AppLocalizations.of(context)!.otherBlogs,
//         style: Theme.of(context).textTheme.headlineMedium,
//       ),
//       body: const MobileBlogs()
//
//     );
//
//   }
// }
