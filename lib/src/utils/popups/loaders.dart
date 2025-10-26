import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class AppLoaders {
  static void hideSnackBar() =>
      ScaffoldMessenger.of(Get.overlayContext!).hideCurrentSnackBar();

  static void customToast(String message) {
    ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppHelperFunctions.isDarkMode(Get.overlayContext!)
                  ? AppColors.darkGrey.withAlpha((0.9 * 255).toInt())
                  : AppColors.grey.withAlpha((0.9 * 255).toInt())),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.overlayContext!).textTheme.labelLarge,
            ),
          ),
        )));
  }

  static void successSnackBar({required String title, String message = '', int duration = 3}) {
    AppHelperFunctions.showSnackBarWithDesign(
        title: title,
        message: message,
        duration: duration,
        backgroundColor: AppColors.primary,
        icon: Icons.check);
  }

  static void warningSnackBar({required String title, String message = '', int duration = 3}) {
    AppHelperFunctions.showSnackBarWithDesign(
        title: title,
        message: message,
        duration: duration,
        backgroundColor: AppColors.warning,
        icon: Icons.warning);
  }

  static void errorSnackBar({required String title, String message = '', int duration = 3}) {
    AppHelperFunctions.showSnackBarWithDesign(
        title: title,
        message: message,
        duration: duration,
        backgroundColor: AppColors.error,
        icon: Icons.warning);
  }
}
