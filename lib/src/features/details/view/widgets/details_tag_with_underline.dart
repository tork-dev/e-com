import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';
import 'package:torganic/src/features/details/model/product_details_model.dart';
import 'package:torganic/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

class AppDetailsTagUnderlineWidget extends StatelessWidget {
  const AppDetailsTagUnderlineWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.types,
        this.haveColor = false,
        this.haveUnderLine = true});

  final String title;
  final VoidCallback onTap;
  final List types;
  final bool haveColor, haveUnderLine;

  @override
  Widget build(BuildContext context) {
    final bottomController = ConvexBottomNavController.instance;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColors.darkGrey,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        ...List.generate(types.length, (index) {
          return InkWell(
            onTap: () {
              final categoryPassingController = Get.put(GetShopDataController());
              //final shopController = Get.put(ShopController());
              categoryPassingController.resetAll();
              if(title == 'Key Ingredients: '){
                categoryPassingController.keyIngredients.value = types[index].slug!;
              }else if(title == 'Tags: '){
                categoryPassingController.tag.value = types[index].slug!;
              }else if(title == 'Categories: '){
                categoryPassingController.categories.value = types[index].slug;
              }
              categoryPassingController.getShopData();
              Get.back();
              bottomController.jumpToTab(1);
            },
            child: Text(
                "${types[index].name!.substring(0, 1).toUpperCase()}${types[index].name!.substring(1)},  ",
                style: TextStyle(
                    fontSize: 14,
                    color: haveColor? AppColors.primary : AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    decoration: haveUnderLine? TextDecoration.underline : null)),
          );
        }),
      ],
    );
  }
}
