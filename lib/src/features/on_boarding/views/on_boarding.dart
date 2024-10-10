import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../controllers/on_boarding_controller.dart';
import './widgets/on_boarding_page.dart';
import './widgets/on_boarding_skip.dart';
import './widgets/on_boarding_dot_navigation.dart';
import './widgets/on_boarding_next_button.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingController = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: onBoardingController.pageController,
            onPageChanged: onBoardingController.updatePageIndicator,
            children: const [
              OnBoardingPage(
                imagePath: AppImages.onBoardingImage1,
                titleText: AppTexts.onBoardingTitle1,
                subtitleText: AppTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                imagePath: AppImages.onBoardingImage2,
                titleText: AppTexts.onBoardingTitle2,
                subtitleText: AppTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                imagePath: AppImages.onBoardingImage3,
                titleText: AppTexts.onBoardingTitle3,
                subtitleText: AppTexts.onBoardingSubTitle3,
              ),

            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}


