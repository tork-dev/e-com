import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:torganic/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:torganic/src/features/wishlist/view/widgets/wishlist_bottom_button.dart';
import 'package:torganic/src/features/wishlist/view/widgets/wishlist_card.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());
    return AppLayoutWithBackButton(
        title: const Text(
          'My WishList',
          style: TextStyle(color: AppColors.primary),
        ),
        leadingIconColor: AppColors.darkGrey,
        padding: 0,
        body: Stack(
          children: [
            AppLayoutWithRefresher(
              onRefresh: controller.onRefresh,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
                  child: AppWishListProductCard(),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
                child: AppWishlistBottomButton(
                ))
          ],
        ));
  }
}
