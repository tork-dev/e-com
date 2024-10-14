import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    final baseUrl = dotenv.env['BASE_URL'];
    return Scaffold(

      backgroundColor: isDark ? AppColors.dark : AppColors.primaryBackground,
      body: Center(
        child: Image(
          width: AppHelperFunctions.screenWidth() * .3,
          image: const AssetImage(AppImages.lightAppLogo),
        ),
      ),
      floatingActionButton: Visibility(
        visible: baseUrl!.contains('beta'),
        child: Image(
          width: AppHelperFunctions.screenWidth() * .3,
          fit: BoxFit.cover,
          image: const AssetImage(AppImages.betaLogo),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}
