import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kirei/src/common/drawer/controller/drawer_controller.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/home/views/widgets/home_appbar_title.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';
import 'package:kirei/src/features/shop/view/widget/shop_page_cards.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../utils/logging/logger.dart';
import '../controller/get_shop_data_controller.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopDataController = Get.put(GetShopDataController());
    final shopController = Get.put(ShopController());
    final drawerController = Get.put(AppDrawerController());
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
      title: AppHomeAppBarTitle(
        globalKey: shopController.shopKey,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        // fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppLayoutWithRefresher(
              onRefresh: shopController.onRefresh,
              scrollController: shopDataController.scrollController,
              children: [
                Gap(70),
                AppShopGridScrollCard(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: AppSizes.sm),
                  color: AppColors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: TextFormField(
                          autofocus: false,
                          onFieldSubmitted: (value){
                            shopDataController.search.value = value;
                            shopDataController.isFromSearch.value = true;
                            shopDataController.allProducts.clear();
                            shopDataController.getShopData();
                            shopDataController.categoryRouteList.add('/shop?${shopDataController.queryStringValue.value}');
                            Log.d('length of routes: ${shopDataController.categoryRouteList}');
                          },
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(AppSizes.md),
                              // Adjust this
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(AppSizes.inputFieldRadius),
                              ),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            hintText: "Search for product",
                          ),
                        ),
                      ),
                      Gap(AppSizes.sm),
                      Expanded(
                        flex: 1,
                        child: AppCardContainer(
                            onTap: () {
                              drawerController.setActiveEndDrawerIndex(0).then((value) =>
                              shopController.shopKey.currentState!.openEndDrawer()
                              );
                            },
                            hasBorder: true,
                            borderColor: AppColors.grey,
                            backgroundColor: AppColors.white,
                            borderRadius: AppSizes.sm,
                            padding: EdgeInsets.all(
                             AppSizes.md,
                            ),
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedFilter,
                              size: 18,
                            ),
                          ),
                      )
                    ],
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
