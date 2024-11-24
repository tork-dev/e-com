import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/styles/app_dividers.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ShopSubCategory extends StatelessWidget {
  const ShopSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    GetShopDataController shopController = GetShopDataController.instance;
    ConvexBottomNavController bottomNavController = ConvexBottomNavController.instance;
    final String baseUrlWeb = dotenv.env["BASE_URL_WEB"]!;
    return AppCardContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.sm,
        ),
         height: 85,
         width: AppHelperFunctions.screenWidth() * 1,
        backgroundColor: AppColors.white,
        applyRadius: false,
        child: Obx(() {
          return AppListViewLayout(
              isScrollVertically: false,
              itemCount: shopController.hittingSubCategoryApi.value
                  ? 5
                  : shopController.subCategoryResponse.length,
              builderFunction: (BuildContext context, int index) =>
                  shopController.hittingSubCategoryApi.value
                      ? ShimmerHelper()
                          .buildBasicShimmer(width: 85, height: 85, radius: 100)
                      : SizedBox(
                          height: 60,
                          width: 60,
                          child: Column(
                            children: [
                              AppBannerImage(
                                height: 60,
                                applyImageRadius: true,
                                boarderRadius: 100,
                                imgBoarderRadius: 100,
                                onPress: (){
                                  shopController.resetAll();
                                  shopController.categories.value = shopController.subCategoryResponse[index].slug;
                                  shopController.getShopData();
                                  // bottomNavController.jumpToTab(1);
                                },
                                isNetworkImage: shopController.subCategoryResponse[index].icon != null,
                                imgUrl: shopController
                                        .subCategoryResponse[index].icon ?? AppImages.placeholder,
                              ),
                              const Gap(AppSizes.xs),
                              Text(
                                shopController.subCategoryResponse[index].name,
                                style: Theme.of(context).textTheme.labelSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ));
        }));
  }
}
