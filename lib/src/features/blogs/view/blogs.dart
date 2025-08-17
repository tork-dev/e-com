import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../controller/blogs_controller.dart';
import 'widget/mobile_blogs.dart';

class Blogs extends StatelessWidget {
  const Blogs({super.key});

  @override
  Widget build(BuildContext context) {
    final blogController = Get.put(BlogsController());
    final isDark = AppHelperFunctions.isDarkMode(context);
    return AppLayoutWithBackButton(
      padding: 0,
      title:  Text(
        "Blogs",
        style: TextStyle(color: AppColors.white),
      ),
      centerTitle: true,
      leadingIconColor: AppColors.white,
      backgroundColor: AppColors.primary,
      body: const MobileBlogs()

    );

  }
}

