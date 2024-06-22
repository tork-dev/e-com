import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/product_image.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class AppGridViewLayout extends StatelessWidget {
  const AppGridViewLayout(
      {required this.builderFunction, required this.itemCount, super.key});

  final int itemCount;

  //final Widget child;
  final Widget Function(BuildContext context, int index) builderFunction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount;
      double childAspectRatio;
      if (constraints.maxWidth < 600) {
        crossAxisCount = 2;
        childAspectRatio = 0.65;
      } else if (constraints.maxWidth < 1200) {
        crossAxisCount = 4;
        childAspectRatio = 0.5;
      } else {
        crossAxisCount = 6;
        childAspectRatio = .65;
      }
      return GridView.builder(
          itemCount: itemCount,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSizes.sm,
              mainAxisSpacing: AppSizes.sm,
              childAspectRatio: childAspectRatio
              // mainAxisExtent: AppHelperFunctions.screenHeight() * 0.30,

              ),
          itemBuilder: (context, index) {
            return builderFunction(context, index);
          });
    });
  }
}
