import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../utils/logging/logger.dart';
import '../../controller/shop_controller.dart';

class AppSortAlertDialog extends StatelessWidget {
  const AppSortAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryPassingController = Get.put(GetShopDataController());
    return AlertDialog(
      contentPadding: const EdgeInsets.only(
        top: 16.0,
        left: 2.0,
        right: 16,
        bottom: 2.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm), // Customize border radius here
      ),
      backgroundColor: AppColors.white,
      content: AppCardContainer(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Sort Products By'),
            ),
            RadioListTile(
              dense: true,
              value: "default",
              groupValue: categoryPassingController.sortKey.value,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Default'),
              onChanged: (value) {
                 categoryPassingController.allProducts.clear();
                categoryPassingController.updateSortKey(value!);
                categoryPassingController.getShopData();
                 categoryPassingController.categoryRouteList.add('/shop?${categoryPassingController.queryStringValue.value}');
                Log.d('length of routes: ${categoryPassingController.categoryRouteList}');
                Get.back();
              },
            ),
            RadioListTile(
              dense: true,
              value: "bestseller",
              groupValue: categoryPassingController.sortKey.value,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Best Selling'),
              onChanged: (value) {
                 categoryPassingController.allProducts.clear();
                categoryPassingController.updateSortKey(value!);
                categoryPassingController.getShopData();
                 categoryPassingController.categoryRouteList.add('/shop?${categoryPassingController.queryStringValue.value}');
                 Log.d('length of routes: ${categoryPassingController.categoryRouteList}');
                Get.back();
              },
            ),
            RadioListTile(
              dense: true,
              value: "rating",
              groupValue: categoryPassingController.sortKey.value,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Rating'),
              onChanged: (value) {
                 categoryPassingController.allProducts.clear();
                categoryPassingController.updateSortKey(value!);
                categoryPassingController.getShopData();
                 categoryPassingController.categoryRouteList.add('/shop?${categoryPassingController.queryStringValue.value}');
                 Log.d('length of routes: ${categoryPassingController.categoryRouteList}');
                Get.back();
              },
            ),
            RadioListTile(
              dense: true,
              value: "new",
              groupValue: categoryPassingController.sortKey.value,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Newest'),
              onChanged: (value) {
                 categoryPassingController.allProducts.clear();
                categoryPassingController.updateSortKey(value!);
                categoryPassingController.getShopData();
                 categoryPassingController.categoryRouteList.add('/shop?${categoryPassingController.queryStringValue.value}');
                 Log.d('length of routes: ${categoryPassingController.categoryRouteList}');
                Get.back();
              },
            ),
            RadioListTile(
              dense: true,
              value: "hot",
              groupValue: categoryPassingController.sortKey.value,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Hot Deal'),
              onChanged: (value) {
                 categoryPassingController.allProducts.clear();
                categoryPassingController.updateSortKey(value!);
                categoryPassingController.getShopData();
                 categoryPassingController.categoryRouteList.add('/shop?${categoryPassingController.queryStringValue.value}');
                 Log.d('length of routes: ${categoryPassingController.categoryRouteList}');
                Get.back();
              },
            ),
            RadioListTile(
              dense: true,
              value: "price-desc",
              groupValue: categoryPassingController.sortKey.value,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Price high to low'),
              onChanged: (value) {
                 categoryPassingController.allProducts.clear();;
                categoryPassingController.updateSortKey(value!);
                categoryPassingController.getShopData();
                 categoryPassingController.categoryRouteList.add('/shop?${categoryPassingController.queryStringValue.value}');
                 Log.d('length of routes: ${categoryPassingController.categoryRouteList}');
                Get.back();
              },
            ),
            RadioListTile(
              dense: true,
              value: "price-asc",
              groupValue: categoryPassingController.sortKey.value,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Price low to high'),
              onChanged: (value) {
                categoryPassingController.allProducts.clear();
                categoryPassingController.updateSortKey(value!);
                categoryPassingController.getShopData();
                categoryPassingController.categoryRouteList.add('/shop?${categoryPassingController.queryStringValue.value}');
                Log.d('length of routes: ${categoryPassingController.categoryRouteList}');
                Get.back();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: ()=> Get.back(),
                    child: Text('Close'.toUpperCase())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
