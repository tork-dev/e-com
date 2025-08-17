import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class AppButtons {



  static AppCardContainer wrapButton({
    required VoidCallback onPressed,
    required String buttonText,
    bool applyRadius = true,
    Color? backgroundColor = AppColors.buttonPrimary,
    Color? buttonTextColor = AppColors.white,
    double buttonRadius = AppSizes.buttonRadius,
    double verticallyPadding = 16,
    double horizontalPadding = 16,
  }){
    return AppCardContainer(
        onTap: onPressed,
        padding: EdgeInsets.symmetric(
          vertical: verticallyPadding,
          horizontal: horizontalPadding,
        ),
        backgroundColor: backgroundColor,
        applyRadius: applyRadius,
        borderRadius: buttonRadius,
        child: Text(buttonText, style: TextStyle(color: buttonTextColor),));
  }

  static ElevatedButton smallRoundButton({
    required VoidCallback onPressed,
    required Color buttonColor,
    required Widget buttonChild,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: buttonColor,
        padding: const EdgeInsets.all(AppSizes.md),
      ),
      child: buttonChild,
    );
  }

  static ElevatedButton largeFlatFilledButton({
    required VoidCallback onPressed,
    required String buttonText,
    bool applyRadius = true,
    Color? backgroundColor = AppColors.buttonPrimary,
    Color? buttonTextColor = AppColors.white,
    double buttonRadius = AppSizes.buttonRadius,
    double verticallyPadding = 16,
    double horizontalPadding = 16,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: applyRadius? BorderRadius.circular(buttonRadius): BorderRadius.zero,
        ),
        minimumSize: Size(AppHelperFunctions.screenWidth(), 0),
        padding: EdgeInsets.symmetric(
          vertical: verticallyPadding,
          horizontal: horizontalPadding,
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        buttonText,
        style: Theme.of(
          Get.context!,
        ).textTheme.titleMedium?.copyWith(color: buttonTextColor),
      ),
    );
  }

  static ElevatedButton customFlatFilledButton({
    required VoidCallback onPressed,
    required String buttonText,
    Color? backgroundColor,
    Color? buttonTextColor = AppColors.white,
    double buttonRadius = 0,
    double verticallyPadding = 16,
    double horizontalPadding = 16,
    required double buttonWidth,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        minimumSize: Size(buttonWidth, 0),
        maximumSize: Size(buttonWidth, 58),
        padding: EdgeInsets.symmetric(
          vertical: verticallyPadding,
          horizontal: horizontalPadding,
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(buttonText, style: TextStyle(color: buttonTextColor)),
    );
  }

  static ElevatedButton largeFlatFilledIconButton({
    required VoidCallback onPressed,
    Color? backgroundColor,
    double buttonRadius = 0,
    double verticallyPadding = 16,
    required String imgUrl,
    required String buttonName,
    required double gapBetweenIconAndText,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        minimumSize: Size(AppHelperFunctions.screenWidth(), 0),
        padding: EdgeInsets.symmetric(
          vertical: verticallyPadding,
          horizontal: AppSizes.md,
        ),
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBannerImage(height: 25, width: 25, imgUrl: imgUrl),
          const Gap(AppSizes.sm),
          Align(alignment: Alignment.center, child: Text(buttonName)),
        ],
      ),
    );
  }

  static OutlinedButton largeFlatOutlineButton({
    required VoidCallback onPressed,
    required String buttonText,
    double buttonRadius = AppSizes.buttonRadius,
    double verticallyPadding = AppSizes.md,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: const BorderSide(color: AppColors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        minimumSize: Size(
          AppHelperFunctions.screenWidth(),
          AppSizes.buttonHeight,
        ),
        padding: EdgeInsets.symmetric(
          vertical: verticallyPadding,
          horizontal: AppSizes.md,
        ),
      ),
      child: Text(
        buttonText,
        style: Theme.of(Get.context!).textTheme.titleMedium,
      ),
    );
  }

  static OutlinedButton largeFlatOutlineButtonWithIcon({
    required VoidCallback onPressed,
    required String buttonText,
    required String imgUrl,
    double buttonRadius = AppSizes.buttonRadius,
    double verticallyPadding = AppSizes.md,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: const BorderSide(color: AppColors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        minimumSize: Size(
          AppHelperFunctions.screenWidth(),
          AppSizes.buttonHeight,
        ),
        padding: EdgeInsets.symmetric(
          vertical: verticallyPadding,
          horizontal: AppSizes.md,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBannerImage(height: 25, width: 25, imgUrl: imgUrl),
          const Gap(AppSizes.sm),
          Text(buttonText, style: Theme.of(Get.context!).textTheme.titleMedium),
        ],
      ),
    );
  }

  static Container smallIconButton({
    required VoidCallback onIconPress,
    required String iconPath,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onIconPress,
        icon: Image(
          width: AppSizes.iconMd,
          height: AppSizes.iconMd,
          image: AssetImage(iconPath),
        ),
      ),
    );
  }

  static InkWell textUnderlineButton({
    required VoidCallback onPressed,
    required String buttonText,
    Color? backgroundColor,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: AppSizes.md,
          decoration: TextDecoration.underline,
          color: backgroundColor,
          decorationColor: backgroundColor,
        ),
      ),
    );
  }
}
