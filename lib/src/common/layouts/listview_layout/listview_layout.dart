import 'package:flutter/material.dart';
import 'package:torganic/src/common/styles/spacing_style.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/common/widgets/containers/product_bottom_container.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../widgets/containers/product_image.dart';

class AppListViewLayout extends StatelessWidget {
  const AppListViewLayout(
      {required this.itemCount,
        required this.builderFunction,
        this.isScrollVertically = true,
        super.key});

  final int itemCount;
  final bool isScrollVertically;
  final Widget Function(BuildContext context, int index) builderFunction;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: AppSpacingStyle.zeroSpacing,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: isScrollVertically ? Axis.vertical : Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
              padding: isScrollVertically
                  ? const EdgeInsets.only(bottom: AppSizes.spaceBtwItems)
                  : const EdgeInsets.only(right: AppSizes.spaceBtwItems),
              child: builderFunction(context, index));
        });
  }
}
