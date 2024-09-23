import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:kirei/src/features/wishlist/view/widgets/wishlist_bottom_button.dart';
import 'package:kirei/src/features/wishlist/view/widgets/wishlist_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());
    return AppLayoutWithBackButton(
      centerTitle: true,
        title: const Text(
          'My WishList',
          style: TextStyle(color: AppColors.secondary),
        ),
        leadingIconColor: AppColors.darkGrey,
        padding: 0,
        body: Stack(
          children: [
            AppLayoutWithRefresher(
              onRefresh: controller.onRefresh,
              children: [
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.md),
                    child: !controller.apiHitting.value &&
                            controller.wishlistProducts.value.data!.isEmpty
                        ? Center(
                            child: Text(
                              'No Wishlist Product',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          )
                        : const AppWishListProductCard(),
                  );
                }),
              ],
            ),
            const Positioned(bottom: 0, child: AppWishlistBottomButton())
          ],
        ));
  }
}
