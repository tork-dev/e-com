import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';
import 'package:torganic/src/features/details/model/product_details_model.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

import '../../../shop/controller/shop_controller.dart';

class AppDetailsTagBorderWidget extends StatelessWidget {
  const AppDetailsTagBorderWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.types});

  final String title;
  final VoidCallback onTap;
  final List types;

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
          final value = types[index];
          return InkWell(
            onTap: () {
              final shopController = Get.put(ShopController());
              shopController.resetAll();
              if(title == 'Skin Types: '){
                shopController.skinType.value = types[index].slug!;
              }else if(title == 'Good For: '){
                shopController.goodFor.value = types[index].slug!;
              }
              shopController.getShopData();
              Get.back();
              bottomController.jumpToTab(1);
            },
            child: AppCardContainer(
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              hasBorder: true,
              applyRadius: false,
              child: Text(
                "${types[index].name!.substring(0, 1).toUpperCase()}${types[index].name!.substring(1)}",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            );
        }),
      ],
    );
  }
}
