import 'package:flutter/material.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class AppDividersStyle{
  static Container fullFlatAppDivider = Container(
    width: AppHelperFunctions.screenWidth() * 1,
    color: AppColors.grey,
    height: 1,
  );
  static Container smallFlatAppDivider = Container(
    width: AppSizes.sm,
    color: AppColors.grey,
    height: 1,
  );
}
