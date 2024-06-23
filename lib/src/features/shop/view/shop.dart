import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:torganic/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/widgets/appbar/appbar_bottom.dart';
import 'package:torganic/src/common/widgets/buttons/app_buttons.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/common/widgets/search_bar/app_bar_search.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/features/shop/view/widget/shop_page_cards.dart';
import 'package:torganic/src/features/shop/view/widget/sort_alert_box.dart';
import 'package:torganic/src/features/shop/view/widget/sub_category.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

import '../../../common/widgets/containers/grid_scroll_card.dart';
import '../controller/get_shop_data_controller.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopController = Get.put(ShopController());
    final shopDataController = Get.put(GetShopDataController());
    return AppLayoutWithDrawer(
        padding: 0,
        globalKey: shopController.shopKey,
        backgroundColor: AppColors.primary,
        leadingIconColor: AppColors.white,
        hasEndDrawer: true,
        action: const [
          Icon(
            Icons.search,
            color: AppColors.white,
          ),
          Gap(AppSizes.sm),
        ],
        title: const AppBarSearch(),
        body: Stack(
          clipBehavior: Clip.none,
          // fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppLayoutWithRefresher(
                  onRefresh: shopController.onRefresh,
                  scrollController: shopDataController.scrollController,
                  children: const [Gap(45), AppShopGridScrollCard()]),
            ),
            Column(
              children: [
                AppBarBottom(
                  onFilterTap: () =>
                      shopController.shopKey.currentState!.openEndDrawer(),
                  onSortTap: () => showDialog(
                    context: context,
                    builder: (context) => const AppSortAlertDialog(),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
