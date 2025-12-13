import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class AppDividersStyle {

  AppDividersStyle._();

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
    return const Divider(thickness: 0.5, indent: 5, endIndent: 5);
  }

  static Widget horizontalDashedLine({
    double dashWidth = 6,
    double dashHeight = 2,
    int dashSpace = 4,
    Color color = Colors.grey,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount =
            (constraints.maxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }

  static Widget verticalDashedLine({
    required double height,
    double dashHeight = 6,
    double dashSpace = 4,
    double lineWidth = 2,
    Color color = Colors.grey,
  }) {
    final dashCount = (height / (dashHeight + dashSpace)).floor();

    return SizedBox(
      height: height,
      child: Column(
        children: List.generate(dashCount, (_) {
          return Padding(
            padding: EdgeInsets.only(bottom: dashSpace),
            child: SizedBox(
              width: lineWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            ),
          );
        }),
      ),
    );
  }

}
