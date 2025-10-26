import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/search_bar/app_bar_search.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';
import 'package:kirei/src/features/shop/view/widget/shop_page_cards.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../../common/widgets/containers/card_container.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/logging/logger.dart';
import '../controller/get_shop_data_controller.dart';

class HotDealsScreen extends StatelessWidget {
  const HotDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopDataController = Get.put(GetShopDataController());
    final shopController = Get.put(ShopController());
    shopDataController.sortKey.value = 'hot';
    shopDataController.getShopData();
    return AppLayoutWithBackButton(
        padding: 0,
        backgroundColor: AppColors.white,
        leadingIconColor: AppColors.darkerGrey,
        bodyBackgroundColor: AppColors.white,
        title: Obx(() {
          return AppBarSearch(
            focusOn: shopDataController.searchOn.value,
            onSubmit: (txt) {
              shopDataController.search.value = txt;
              shopDataController.isFromSearch.value = true;
              shopDataController.allProducts.clear();
              shopDataController.getShopData();
              shopDataController.categoryRouteList.add('/shop?${shopDataController.queryStringValue.value}');
              Log.d('length of routes: ${shopDataController.categoryRouteList}');
              return null;
            },
            prevRoute: '/shop?${shopDataController.queryStringValue.value}',
          );
        }),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppLayoutWithRefresher(
              onRefresh: shopController.onRefresh,
              scrollController: shopDataController.scrollController,
              children: [
                const Gap(AppSizes.defaultSpace),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      AppCardContainer(
                        hasBorder: true,
                        borderWidth: 1,
                        borderColor: AppColors.borderPrimary,
                        padding: EdgeInsets.all(AppSizes.md),
                        child: Column(
                          children: [
                            Text("Sale ends in", style: Theme.of(context).textTheme.headlineLarge),
                            Gap(AppSizes.sm),
                            Obx(() {
                                return shopDataController.allProducts.isEmpty ?
                                ShimmerHelper().buildBasicShimmer(height: 50) :
                                  SlideCountdownSeparated(
                                  style: Theme.of(context).textTheme.headlineSmall!.apply(color: AppColors.white),
                                  duration: AppHelperFunctions().getRemainingDuration(shopDataController.allProducts[0].flashSaleEndDate!),
                                  padding: EdgeInsets.all(AppSizes.md),
                                  separatorStyle: Theme.of(context).textTheme.titleMedium!,
                                  separatorPadding: EdgeInsets.all(AppSizes.sm),
                                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppSizes.cardRadiusXs)),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(AppSizes.defaultSpace),
                const AppShopGridScrollCard()]),
        ));
  }
}
