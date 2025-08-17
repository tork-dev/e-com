import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppGridViewLayout extends StatelessWidget {
  const AppGridViewLayout(
      {required this.itemCount,
      required this.builderFunction,
      this.scrollController,
      this.mobileAspect = 0.65,
      this.tabletAspect = 0.5,
      this.desktopAspect = .65,
        this.cardHeight = 310,
      super.key});

  final int itemCount;
  final ScrollController? scrollController;
  final double mobileAspect, tabletAspect, desktopAspect, cardHeight;

  //final Widget child;
  final Widget Function(BuildContext context, int index) builderFunction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount;
      if (constraints.maxWidth < 600) {
        crossAxisCount = 2;
      } else if (constraints.maxWidth < 1200) {
        crossAxisCount = 4;
      } else {
        crossAxisCount = 6;
      }

      final screenWidth = constraints.maxWidth;
      final totalSpacing = (crossAxisCount - 1) * AppSizes.md;
      final itemWidth = (screenWidth - totalSpacing) / crossAxisCount;
      final childAspectRatio = itemWidth / cardHeight;

      return GridView.builder(
          itemCount: itemCount,
          shrinkWrap: true,
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSizes.md,
              mainAxisSpacing: AppSizes.md,
              childAspectRatio: childAspectRatio
              // mainAxisExtent: AppHelperFunctions.screenHeight() * 0.30,

              ),
          itemBuilder: (context, index) {
            return builderFunction(context, index);
          });
    });
  }
}
