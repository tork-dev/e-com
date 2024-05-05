import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/product_image.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class AppGridViewLayout extends StatelessWidget {
  const AppGridViewLayout(
      {this.crossAxisCount = 2,
        required this.child,
        required this.itemCount,
        super.key});

  final int crossAxisCount, itemCount;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSizes.spaceBtwItems,
          mainAxisSpacing: AppSizes.spaceBtwItems,
          mainAxisExtent: AppHelperFunctions.screenHeight() * 0.25,

        ),
        itemBuilder: (context, index) {
          return child;
        });
  }
}