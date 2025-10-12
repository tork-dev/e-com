import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/widgets/appbar/appbar_bottom.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/search_bar/app_bar_search.dart';
import 'package:kirei/src/features/checkout/view/widget/coupon_field.dart';
import 'package:kirei/src/features/home/views/widgets/home_appbar_title.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';
import 'package:kirei/src/features/shop/view/widget/shop_page_cards.dart';
import 'package:kirei/src/features/shop/view/widget/sort_alert_box.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../utils/logging/logger.dart';
import '../controller/get_shop_data_controller.dart';

class ShopScreenNew extends StatelessWidget {
  const ShopScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    final shopDataController = Get.put(GetShopDataController());
    final shopController = Get.put(ShopController());
    return AppLayoutWithDrawer(
      backToHome: true,
      inHome: true,
      padding: 0,
      globalKey: shopController.shopKey,
      backgroundColor: AppColors.white,
      leadingIconColor: AppColors.darkerGrey,
      bodyBackgroundColor: AppColors.white,
      hasEndDrawer: true,
      action: const [SizedBox()],
      title: AppHomeAppBarTitle(),
      // title: Obx(() {
      //   return AppBarSearch(
      //     focusOn: shopDataController.searchOn.value,
      //     onSubmit: (txt) {
      //       shopDataController.search.value = txt;
      //       shopDataController.isFromSearch.value = true;
      //       shopDataController.allProducts.clear();
      //       shopDataController.getShopData();
      //       shopDataController.categoryRouteList.add('/shop?${shopDataController.queryStringValue.value}');
      //       Log.d('length of routes: ${shopDataController.categoryRouteList}');
      //       return null;
      //     },
      //     prevRoute: '/shop?${shopDataController.queryStringValue.value}',
      //   );
      // }),
      body: Stack(
        clipBehavior: Clip.none,
        // fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppLayoutWithRefresher(
              onRefresh: shopController.onRefresh,
              scrollController: shopDataController.scrollController,
              children: const [Gap(120), AppShopGridScrollCard()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: AppSizes.md),
                  color: AppColors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(AppSizes.md), // Adjust this
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedSearch01,
                          size: AppSizes.iconMd,
                          color: AppColors.grey,
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        minHeight: 24,
                        minWidth: 24,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSizes.inputFieldRadius)),
                        borderSide: BorderSide(color: AppColors.grey)
                      ),
                      hintText: "Search for product",
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
