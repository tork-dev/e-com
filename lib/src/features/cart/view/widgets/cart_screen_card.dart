import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/cart/view/widgets/log_out_view.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class AppCartProductCard extends StatelessWidget {
  const AppCartProductCard({super.key});



  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final bottomNavController = ConvexBottomNavController.instance;
    return Obx(() {
      return cartController.allCartProducts.isEmpty && !cartController.hittingApi.value
          ? CartLogOutView(
              onTap: () {
                bottomNavController.jumpToTab(1);
              },
              imgUrl: AppImages.emptyShoppingBag,
              titleText: 'No Products added to the cart',
              buttonName: 'GO SHOP')
          : AppListViewLayout(
              itemCount: cartController.allCartProducts.isEmpty
                  ? 5
                  : cartController.allCartProducts[0].cartItems!.length,
              builderFunction: (context, index) => cartController
                      .allCartProducts.isEmpty
                  ? ShimmerHelper().buildBasicShimmer(height: 150)
                  : AppCardContainer(
                      onTap: ()=> Get.toNamed('/product/${cartController.allCartProducts[0].cartItems![index].slug}'),
                      backgroundColor: AppColors.white,
                      applyRadius: false,
                      padding: const EdgeInsets.all(AppSizes.sm),
                      margin: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                AppBannerImage(
                                    height: 100,
                                    width: 70,
                                    applyImageRadius: false,
                                    isNetworkImage: cartController.allCartProducts[0]
                                        .cartItems![index].productThumbnailImage != null,
                                    fit: BoxFit.fill,
                                    imgUrl: cartController.allCartProducts[0]
                                        .cartItems![index].productThumbnailImage ?? AppImages.placeholder),
                                const Gap(AppSizes.spaceBtwSmallItem),
                                AppCardContainer(
                                   width: 200,
                                    height: 100,
                                    //backgroundColor: AppColors.secondary,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartController.allCartProducts[0]
                                              .cartItems![index].productName!,
                                          style: const TextStyle(fontSize: 16),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Gap(AppSizes.spaceBtwSmallItem),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '৳${cartController.allCartProducts[0].cartItems![index].price! * cartController.allCartProducts[0].cartItems![index].quantity!}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  AppHelperFunctions.showAlert(
                                                      onRightPress: () {
                                                        cartController
                                                            .getCartDelete(
                                                                cartController
                                                                    .allCartProducts[
                                                                        0]
                                                                    .cartItems![index]
                                                                    .id!)
                                                            .then((value) {
                                                          cartController
                                                              .onRefresh()
                                                              .then((value) => {
                                                                    cartController
                                                                            .cartCount
                                                                            .value =
                                                                        cartController
                                                                            .cartProductDeleteResponse
                                                                            .value
                                                                            .cartQuantity!,
                                                                    Get.back(),
                                                                    AppHelperFunctions.showToast(
                                                                        cartController
                                                                            .cartProductDeleteResponse
                                                                            .value
                                                                            .message!),
                                                                  });
                                                        });
                                                      },
                                                      onLeftPress: ()=> Get.back(),
                                                      message:
                                                          'Are you sure to remove this item?',
                                                      leftButtonName: 'Cancel',
                                                      rightButtonName: 'Confirm',
                                                      rightButtonColor: AppColors.primary);
                                                },
                                                child: const Icon(
                                                    Icons.delete_forever_outlined))
                                          ],
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          const Gap(AppSizes.spaceBtwSections),
                          AppCardContainer(
                              height: 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                          cartController
                                              .getCartUpdateQuantity(
                                                  cartController
                                                      .allCartProducts[0]
                                                      .cartItems![index]
                                                      .id!,
                                                  cartController
                                                          .allCartProducts[0]
                                                          .cartItems![index]
                                                          .quantity! +
                                                      1)
                                              .then((value) =>
                                                  cartController.onRefresh())
                                              .then((value) => {
                                                    AppHelperFunctions.showToast(
                                                        cartController
                                                            .cartUpdateResponse
                                                            .value
                                                            .message!),
                                                  });
                                      },
                                      child: const Icon(Icons.add)),
                                  AppCardContainer(
                                      height: 25,
                                      width: 25,
                                      applyRadius: false,
                                      borderWidth: 1,
                                      hasBorder: true,
                                      borderColor: AppColors.secondary,
                                      child: Center(
                                          child: Text(cartController
                                              .allCartProducts[0]
                                              .cartItems![index]
                                              .quantity!
                                              .toString()))),
                                  InkWell(
                                      onTap: () {
                                        if (cartController.allCartProducts[0]
                                                .cartItems![index].quantity! >
                                            cartController
                                                .allCartProducts[0]
                                                .cartItems![index]
                                                .lowerLimit!) {
                                          cartController
                                              .getCartUpdateQuantity(
                                                  cartController
                                                      .allCartProducts[0]
                                                      .cartItems![index]
                                                      .id!,
                                                  cartController
                                                          .allCartProducts[0]
                                                          .cartItems![index]
                                                          .quantity! -
                                                      1)
                                              .then((value) =>
                                                  cartController.onRefresh())
                                              .then((value) => {
                                                    AppHelperFunctions.showToast(
                                                        cartController
                                                            .cartUpdateResponse
                                                            .value
                                                            .message!),
                                                  });
                                        } else {
                                          AppHelperFunctions.showToast(
                                              'Cannot order less than ${cartController.allCartProducts[0].cartItems![index].lowerLimit}');
                                        }
                                      },
                                      child: const Icon(Icons.remove)),
                                ],
                              ))
                        ],
                      ),
                    ),
            );
    });
  }
}
