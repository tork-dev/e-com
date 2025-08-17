import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class AppDividersStyle{
  static Container fullFlatAppDivider = Container(
    width: AppHelperFunctions.screenWidth() * 1,
    color: AppColors.lightGrey,
    height: 1,
  );

  static Container smallFlatAppDivider = Container(
    width: AppSizes.sm,
    color: AppColors.grey,
    height: 1,
  );

  static Divider appDivider() {
    return const Divider(
        thickness: 0.5,
        indent: 5,
        endIndent: 5);
    }

}
