import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/cart/view/widgets/cart_proceed_button.dart';
import 'package:kirei/src/features/cart/view/widgets/cart_screen_card.dart';
import 'package:kirei/src/features/cart/view/widgets/log_out_view.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    // final bottomNavController = ConvexBottomNavController.instance;
    return AppLayoutWithDrawer(
        globalKey: controller.cartKey,
        backToHome: true,
        inHome: true,
        title: const Text('Shopping Cart',
            style: TextStyle(color: AppColors.white)),
        centerTitle: true,
        bodyBackgroundColor: AppColors.lightGrey,
        backgroundColor: AppColors.primary,
        padding: 0,
        body: AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true
            ? Stack(
                children: [
                  AppLayoutWithRefresher(
                    onRefresh: controller.onRefresh,
                    children: const [
                      Column(
                        children: [
                          Gap(AppSizes.md),
                          AppCartProductCard(),
                          Gap(200)
                        ],
                      )
                    ],
                  ),
                  Obx(() {
                    return Visibility(
                      visible: controller.allCartProducts.isNotEmpty,
                      child: const Positioned(
                          bottom: 0, child: AppCartProceedButton()),
                    );
                  })
                ],
              )
            : Center(
                child: CartLogOutView(
                  onTap: () {
                    Get.to(()=> const LogIn());
                  },
                  imgUrl: AppImages.profileIcon,
                  titleText: 'Please log in to see cart item',
                  buttonName: 'Login Now',
                ),
              ));
  }
}
