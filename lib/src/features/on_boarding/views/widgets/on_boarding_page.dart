import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {

  final String imagePath, titleText, subtitleText;

  const OnBoardingPage({
    super.key,
    required this.imagePath,
    required this.titleText,
    required this.subtitleText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        children: [
          Image(
              width: AppHelperFunctions.screenWidth() * 0.8,
              height: AppHelperFunctions.screenHeight() * 0.6,
              image: AssetImage(imagePath), ),
          Text(
            titleText,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const Gap(AppSizes.spaceBtwDefaultItems),
          Text(
            subtitleText,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}