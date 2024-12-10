import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppSpacingStyle{
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight,
    left: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace
  );

  // static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
  //     top: AppSizes.appBarHeight,
  //     left: AppSizes.defaultSpace,
  //     right: AppSizes.defaultSpace,
  //     bottom: AppSizes.defaultSpace
  // );

  static const EdgeInsetsGeometry defaultSpacing = EdgeInsets.symmetric(
      horizontal: AppSizes.defaultSpace
  );

  static const EdgeInsetsGeometry allSIdeSpacing = EdgeInsets.all(
    AppSizes.defaultSpace
  );

  static const EdgeInsetsGeometry zeroSpacing = EdgeInsets.zero;
}
