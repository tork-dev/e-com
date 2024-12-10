import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/on_boarding_controller.dart';


class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dotNavigationController = OnBoardingController.instance;
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: AppDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: AppSizes.defaultSpace,
      child: SmoothPageIndicator(
          controller: dotNavigationController.pageController,
          onDotClicked: dotNavigationController.dotNavigationClick,
          effect: ExpandingDotsEffect(
              activeDotColor: isDark ? AppColors.light : AppColors.dark,
              dotHeight: 6),
          count: 3),
    );
  }
}
