import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';

import '../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/styles/app_dividers.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/sizes.dart';

class ShopSubCategory extends StatelessWidget {
  const ShopSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    GetShopDataController shopController = GetShopDataController.instance;
    return AppCardContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.sm,
        ),
        height: 85,
        backgroundColor: AppColors.white,
        applyRadius: false,
        child: Obx(() {
          return AppListViewLayout(
              isScrollVertically: false,
              itemCount: shopController.hittingApi.value
                  ? 5
                  : shopController.subCategoryResponse.length,
              builderFunction: (BuildContext context, int index) =>
                  shopController.hittingApi.value
                      ? ShimmerHelper()
                          .buildBasicShimmer(width: 85, radius: 100)
                      :
                  Column(
                              children: [
                                AppBannerImage(
                                  height: 60,
                                  width: 60,
                                  isNetworkImage: true,
                                  imgUrl: shopController
                                          .subCategoryResponse[index].icon ??
                                      'https://kireibd.com/images/home/categories/New-Arrivals.png',
                                ),
                                const Gap(AppSizes.sm),
                                Text(
                                  shopController
                                      .subCategoryResponse[index].name,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                AppDividersStyle.fullFlatAppDivider,
                              ],
                            ));
        }));
  }
}
