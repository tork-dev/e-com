import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class AppButtons {
  static ElevatedButton smallRoundButton(
      {required VoidCallback onPressed,
      required Color buttonColor,
      required Widget buttonChild}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: buttonColor,
            padding: const EdgeInsets.all(AppSizes.md)),
        child: buttonChild);
  }

  static ElevatedButton largeFlatFilledButton(
      {required VoidCallback onPressed,
      required String buttonText,
      Color? backgroundColor,
      Color? buttonTextColor = AppColors.white,
      double buttonRadius = 0,
      double verticallyPadding = 16,
      double horizontalPadding = 16,
      }) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          minimumSize:  Size(AppHelperFunctions.screenWidth(), 0),
          padding: EdgeInsets.symmetric(vertical: verticallyPadding, horizontal: horizontalPadding),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor),
        ));
  }


  static ElevatedButton customFlatFilledButton(
      {required VoidCallback onPressed,
        required String buttonText,
        Color? backgroundColor,
        Color? buttonTextColor = AppColors.white,
        double buttonRadius = 0,
        double verticallyPadding = 16,
        double horizontalPadding = 16,
        required double buttonWidth
      }) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          minimumSize:  Size(buttonWidth, 0),
          maximumSize: Size(AppHelperFunctions.screenWidth(), 58),
          padding: EdgeInsets.symmetric(vertical: verticallyPadding, horizontal: horizontalPadding),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor),
        ));
  }


  static ElevatedButton largeFlatFilledIconButton(
      {required VoidCallback onPressed,
      Color? backgroundColor,
      double buttonRadius = 0,
      double verticallyPadding = 16,
      required String imgUrl,
      required String buttonName,
      required double gapBetweenIconAndText}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          minimumSize: Size(AppHelperFunctions.screenWidth(), 0),
          padding: EdgeInsets.symmetric(
              vertical: verticallyPadding, horizontal: AppSizes.md),
          backgroundColor: backgroundColor,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppBannerImage(height: 25, width: 25, imgUrl: imgUrl),
          const Gap(AppSizes.sm),
          Align(alignment: Alignment.center, child: Text(buttonName)),
        ]));
  }

  static OutlinedButton largeFlatOutlineButton({
    required VoidCallback onPressed,
    required String buttonText,
    double verticallyPadding = AppSizes.md,
  }) {
    return OutlinedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            side: const BorderSide(color: AppColors.secondary),
            shape: const BeveledRectangleBorder(),
            minimumSize:
                Size(AppHelperFunctions.screenWidth(), AppSizes.buttonHeight),
            padding: EdgeInsets.symmetric(
                vertical: verticallyPadding, horizontal: AppSizes.md)),
        child: Text(
          buttonText,
        ));
  }

  static Container smallIconButton(
      {required VoidCallback onIconPress, required String iconPath}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(100)),
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

  static TextButton textUnderlineButton({
    required VoidCallback onPressed,
    required String buttonText,
    Color? backgroundColor,
  }) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: AppSizes.md,
            decoration: TextDecoration.underline,
            color: backgroundColor,
            decorationColor: backgroundColor,
          ),
        ));
  }
}
