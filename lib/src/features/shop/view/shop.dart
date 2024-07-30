import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/widgets/appbar/appbar_bottom.dart';
import 'package:kirei/src/common/widgets/search_bar/app_bar_search.dart';
import 'package:kirei/src/features/shop/controller/shop_controller.dart';
import 'package:kirei/src/features/shop/view/widget/shop_page_cards.dart';
import 'package:kirei/src/features/shop/view/widget/sort_alert_box.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../controller/get_shop_data_controller.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {

    String? searchName = Get.parameters['search'];
    String? sortKey = Get.parameters['order_by'];
    String? tag = Get.parameters['tag'];
    String? skinType = Get.parameters['skin_type'];
    String? search = Get.parameters['search'];
    String? keyIngredients = Get.parameters['key_ingredients'];
    String? goodFor = Get.parameters['good_for'];
    String? categories = Get.parameters['category'];
    String? pageNumber = Get.parameters['page'];
    String? type = Get.parameters['type'];

    final shopController = Get.put(ShopController());
    final shopDataController = Get.put(GetShopDataController());

    // shopDataController.searchName.value = search;
    // RxString sortKey = 'default'.obs;
    // RxString tag = ''.obs;
    // RxString skinType = ''.obs;
    // RxString search = ''.obs;
    // RxString keyIngredients = ''.obs;
    // RxString goodFor = ''.obs;
    // RxString categories = ''.obs;
    // RxInt pageNumber = 1.obs;
    // RxString type = ''.obs;

    return AppLayoutWithDrawer(
      backToHome: true,
        inHome: true,
        padding: 0,
        globalKey: shopController.shopKey,
        backgroundColor: AppColors.primary,
        leadingIconColor: AppColors.white,
        hasEndDrawer: true,
        action:  const [
          SizedBox()
        ],
        title: Obx(() {
            return AppBarSearch(
              focusOn: shopDataController.searchOn.value,
              onSubmit: (txt){
                shopDataController.search.value = txt;
                shopDataController.isFromSearch.value = true;
                shopDataController.allProducts.clear();
                shopDataController.getShopData();
              },
            );
          }
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
                  children: const [
                    Gap(45),
                    AppShopGridScrollCard()]),
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
