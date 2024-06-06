import 'dart:ui';

import 'package:flutter/material.dart';
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
            shape: const CircleBorder(), backgroundColor: buttonColor),
        child: buttonChild);
  }

  static ElevatedButton largeFlatFilledButton(
      {required VoidCallback onPressed,
      required String buttonText,
       Color? backgroundColor,
        double buttonRadius = 0,
        double verticallyPadding = 16
      }) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            minimumSize: Size(AppHelperFunctions.screenWidth(), 0),
            //padding: EdgeInsets.symmetric(vertical: verticallyPadding),
            backgroundColor: backgroundColor,
        ),
        child: Text(
          buttonText,
        ));
  }

  static OutlinedButton largeFlatOutlineButton(
      {required VoidCallback onPressed,
      required String buttonText}) {
    return OutlinedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: const BeveledRectangleBorder(),
            minimumSize:
                Size(AppHelperFunctions.screenWidth(), AppSizes.buttonHeight)),
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

     static TextButton textUnderlineButton(
      {required VoidCallback onPressed,
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


