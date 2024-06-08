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
        this.applyPadding = true,
        this.physics = const BouncingScrollPhysics(),
        super.key});

  final int itemCount;
  final bool isScrollVertically, applyPadding;
  final Widget Function(BuildContext context, int index) builderFunction;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: AppSpacingStyle.zeroSpacing,
        shrinkWrap: true,
        physics: physics,
        scrollDirection: isScrollVertically ? Axis.vertical : Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
              padding: isScrollVertically
                  ?applyPadding? const EdgeInsets.only(bottom: AppSizes.spaceBtwItems) : EdgeInsets.zero
                  :applyPadding? const EdgeInsets.only(right: AppSizes.spaceBtwItems) : EdgeInsets.zero,
              child: builderFunction(context, index));
        });
  }
}
