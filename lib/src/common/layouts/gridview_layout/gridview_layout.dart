import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppGridViewLayout extends StatelessWidget {
  const AppGridViewLayout(
      {required this.itemCount,
      required this.builderFunction,
      this.scrollController,
      this.mobileAspect = 0.631,
      this.tabletAspect = 0.5,
      this.desktopAspect = .65,
      super.key});

  final int itemCount;
  final ScrollController? scrollController;
  final double mobileAspect, tabletAspect, desktopAspect;

  //final Widget child;
  final Widget Function(BuildContext context, int index) builderFunction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount;
      double childAspectRatio;
      if (constraints.maxWidth < 600) {
        crossAxisCount = 2;
        childAspectRatio = mobileAspect;
      } else if (constraints.maxWidth < 1200) {
        crossAxisCount = 4;
        childAspectRatio = tabletAspect;
      } else {
        crossAxisCount = 6;
        childAspectRatio = desktopAspect;
      }
      return GridView.builder(
          itemCount: itemCount,
          shrinkWrap: true,
          controller: scrollController,
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
