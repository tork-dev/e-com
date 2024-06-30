import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/containers/product_image.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class AppGridViewLayout extends StatelessWidget {
  const AppGridViewLayout(
      {required this.builderFunction, required this.itemCount, this.scrollController, super.key});

  final int itemCount;
  final ScrollController? scrollController;

  //final Widget child;
  final Widget Function(BuildContext context, int index) builderFunction;

  @override
  Widget build(BuildContext context) {
    final categoryPassignController = GetShopDataController.instance;
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
