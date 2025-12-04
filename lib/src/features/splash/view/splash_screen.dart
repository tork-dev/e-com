import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/helpers/env_config.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    final bool isDark = AppHelperFunctions.isDarkMode(context);
    final String baseUrl = EnvConfig.baseUrl;
    return Scaffold(

      backgroundColor: isDark ? AppColors.dark : AppColors.primaryBackground,
      body: Center(
        child: baseUrl.contains('beta') ?
        Banner(
          message: 'BETA',
          location: BannerLocation.topStart,
          child: Image(
            width: AppHelperFunctions.screenWidth() * .3,
            image: const AssetImage(AppImages.lightAppLogo),
          ),
        ) :
        Image(
          width: AppHelperFunctions.screenWidth() * .3,
          image: const AssetImage(AppImages.lightAppLogo),
        ),
      ),
    );
  }
}
