import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/containers/banner_image.dart';

class SkinCareCardAiCard extends StatelessWidget {
  const SkinCareCardAiCard({
    super.key,
    this.backgroundColor = AppColors.contentInversePrimary,
    this.title,
    this.subtitle,
    this.buttonText,
    this.imageUrl,
    this.onPress,
    this.hasImageSize = false,
  });

  final Color? backgroundColor;
  final String? title, subtitle, buttonText, imageUrl;
  final VoidCallback? onPress;
  final bool hasImageSize;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      height: 593,
      width: AppHelperFunctions.screenWidth(),
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "Skin Care with AI",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
                ),
                Gap(AppSizes.spaceBtwDefaultItems),
                HtmlWidget(
                  subtitle ?? "Discover the perfect skin care products tailored just for you with our innovative AI Skin Recommendation feature.",
                  textStyle: Theme.of(context).textTheme.bodySmall
                ),
                Gap(AppSizes.defaultSpace),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20.5,
                    ),
                  ),
                  onPressed: onPress,
                  child: Text(
                    buttonText ?? "Start Personalized Test",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Stack(
            // fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              AppBannerImage(
                width: AppHelperFunctions.screenWidth(),
                height: hasImageSize? 280 : null,
                imgBoarderRadius: AppSizes.cardRadiusMd,
                isNetworkImage: imageUrl != null,
                 imgUrl: imageUrl ?? "assets/images/banners/skin_care_with_ai.png", // <-- replace with your asset
                 fit: BoxFit.contain,
               )
            ],
          ),
        ],
      ),
    );
  }
}
