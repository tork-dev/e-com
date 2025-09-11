import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/features/home/model/home_products_model.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../containers/card_container.dart';

class AppBottomButton extends StatelessWidget {
  const AppBottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsPageController.instance;
    final bottomNavController = ConvexBottomNavController.instance;
    return Obx(() {
      return detailsController.productDetails.value.detailedProducts == null
          ? ShimmerHelper().buildBasicShimmer(
              height: 50, width: AppHelperFunctions.screenWidth() * 1)
          : detailsController.productDetails.value.detailedProducts!.stock != 0
              ? Row(
                  children: [
                    AppCardContainer(
                        onTap: () {
                          // if (AppLocalStorage()
                          //         .readData(LocalStorageKeys.isLoggedIn) !=
                          //     true) {
                          //   Get.to(() => const LogIn(), arguments: {"prevRoute" : Get.currentRoute});
                          //   // Get.toNamed(
                          //   //     '/login/product/${detailsController.productSlug.value}');
                          //   return;
                          // }

                          detailsController.onAddToCart().then((value) =>
                              detailsController.isAddedToCart.value = true);
                        },
                        height: 50,
                        width: AppHelperFunctions.screenWidth() / 2,
                        applyRadius: false,
                        backgroundColor: AppColors.secondary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_bag_outlined,
                              color: AppColors.white,
                              size: 20,
                            ),
                            Text(
                              ' Add To Cart',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .apply(color: AppColors.white),
                            )
                          ],
                        )),
                    AppCardContainer(
                        onTap: () {
                          if (AppLocalStorage()
                                  .readData(LocalStorageKeys.isLoggedIn) !=
                              true) {
                            Get.to(() => const LogIn(), arguments: {"prevRoute" : Get.currentRoute});
                            // Get.toNamed(
                            //     '/login/product/${detailsController.productSlug.value}');
                            return;
                          }

                          detailsController.isAddedToCart.value == false
                              ? detailsController
                                  .onAddToCart()
                                  .then((value) => {Get.offAllNamed('/cart')})
                              : Get.offAllNamed('/cart');
                        },
                        height: 50,
                        width: AppHelperFunctions.screenWidth() / 2,
                        applyRadius: false,
                        backgroundColor:
                            detailsController.isAddedToCart.value == false
                                ? AppColors.primary
                                : AppColors.warning,
                        child: Center(
                            child: Text(
                                detailsController.isAddedToCart.value == false
                                    ? 'Buy Now'
                                    : 'Go To Cart',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(color: AppColors.white)))),
                  ],
                )
              : AppCardContainer(
                  onTap: () {
                    if (AppLocalStorage()
                            .readData(LocalStorageKeys.isLoggedIn) !=
                        true) {
                      Get.to(() => const LogIn(), arguments: {"prevRoute" : Get.currentRoute});
                      return;
                    }
                    final cartController = Get.put(CartController());
                    detailsController.productDetails.value.detailedProducts!
                                .preorderAvailable !=
                            0
                        ? cartController
                            .getAddToCartResponse(
                                detailsController.productDetails.value.detailedProducts as Product)
                            .then((value) {
                            AppHelperFunctions.showToast(cartController
                                .addToCartResponse.value.message!);
                            Get.back();
                            bottomNavController.jumpToTab(2);
                          })
                        : detailsController.productDetails.value
                                    .detailedProducts!.requestAvailable !=
                                0
                            ? cartController
                                .getRequestResponse(
                                    productId: detailsController.productDetails
                                        .value.detailedProducts!.id!)
                                .then((value) {
                                AppHelperFunctions.showToast(cartController
                                    .requestStockResponse.value.message!);
                              })
                            : null;
                  },
                  height: 50,
                  width: AppHelperFunctions.screenWidth() * 1,
                  applyRadius: false,
                  backgroundColor: detailsController.productDetails.value
                              .detailedProducts?.preorderAvailable !=
                          0
                      ? AppColors.preorder
                      : detailsController.productDetails.value.detailedProducts
                                  ?.requestAvailable !=
                              0
                          ? AppColors.request
                          : AppColors.primary,
                  child: Center(
                      child: Text(
                          detailsController.productDetails.value
                                      .detailedProducts?.preorderAvailable !=
                                  0
                              ? 'Preorder Now'
                              : detailsController.productDetails.value
                                          .detailedProducts?.requestAvailable !=
                                      0
                                  ? 'Request Stock'
                                  : 'Out of Stock',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .apply(color: AppColors.white))));
    });
  }
}
