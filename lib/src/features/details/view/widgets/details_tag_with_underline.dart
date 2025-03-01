import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/features/details/model/product_details_model.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

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
    GetShopDataController categoryPassingController = GetShopDataController.instance;
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
              categoryPassingController.resetAll();
              if(title == 'Key Ingredients: '){
                Get.offAllNamed('/shop?key_ingredients=${types[index].slug!}');
              }else if(title == 'Tags: '){
                Get.offAllNamed('/shop?tag=${types[index].slug!}');
              }else if(title == 'Categories: '){
                Get.offAllNamed('/shop?category=${types[index].slug!}');
              }
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
