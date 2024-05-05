import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../controller/splash_controller.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? AppColors.dark : AppColors.primaryBackground,
      body: Center(
        child: Image(
          width: AppHelperFunctions.screenWidth() * .3,
          image: const AssetImage(AppImages.darkAppLogo1),
        ),
      ),
    );
  }
}
