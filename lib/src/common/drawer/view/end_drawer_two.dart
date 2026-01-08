import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import '../../../features/bottom_navigation/convex_controller.dart';
import '../../../features/cart/view/widgets/log_out_view.dart';
import '../../../features/checkout/model/checkout_summary_respopnse.dart';
import '../../../features/checkout/view/checkout_screen.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../layouts/listview_layout/listview_layout.dart';
import '../../styles/app_dividers.dart';
import '../../styles/skeleton_style.dart';
import '../../widgets/buttons/app_buttons.dart';
import '../../widgets/containers/card_container.dart';
import '../controller/drawer_controller.dart';

class AppEndDrawerTwo extends StatelessWidget {
  const AppEndDrawerTwo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppDrawerController());
    final CartController cartController = Get.put(CartController());
    final bottomNavController = ConvexBottomNavController.instance;

    return AppCardContainer(
      width: 350,
      height: AppHelperFunctions.screenHeight(),
      padding: const EdgeInsets.only(
        left: AppSizes.defaultSpace,
        right: AppSizes.defaultSpace,
        top: AppSizes.appBarHeight,
      ),
      backgroundColor: AppColors.secondaryBackground,
      applyRadius: true,
      child: Column(
        children: [
          /// -------- HEADER ----------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shopping Cart",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              InkWell(
                onTap: () => Get.back(),
                child: const HugeIcon(icon: HugeIcons.strokeRoundedCancel01),
              ),
            ],
          ),
          const Gap(AppSizes.sm),
          AppDividersStyle.fullFlatAppDivider,
          const Gap(AppSizes.md),

          /// -------- SCROLLABLE PRODUCT LIST ----------
          Expanded(
            child: Obx(() {
              return cartController.allCartProducts.isEmpty &&
                      !cartController.hittingApi.value
                  ? CartLogOutView(
                      onTap: () {
                        bottomNavController.jumpToTab(1);
                      },
                      imgUrl: AppImages.emptyShoppingBagIcon,
                      titleText: 'No Products added to the cart',
                      buttonName: 'GO SHOP',
                    )
                  : AppListViewLayout(
                      shrinkWrap: false,
                      physics: const BouncingScrollPhysics(),
                      itemCount: cartController.allCartProducts.isEmpty
                          ? 5
                          : cartController.allCartProducts.length,
                      builderFunction: (context, index) {
                        if (cartController.allCartProducts.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.md,
                            ),
                            child: ShimmerHelper().buildBasicShimmer(
                              height: 80,
                            ),
                          );
                        }

                        final product = cartController.allCartProducts[index];

                        return AppCardContainer(
                          backgroundColor: AppColors.white,
                          borderRadius: AppSizes.borderRadiusMd,
                          padding: const EdgeInsets.all(AppSizes.md),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /// Product Image + Info
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppBannerImage(
                                    onPress: () => Get.toNamed(
                                      '/product/${product.slug}',
                                      parameters: {'prevRoute': '/cart'},
                                    ),
                                    height: 70,
                                    width: 40,
                                    backgroundColor:
                                        AppColors.secondaryBackground,
                                    applyImageRadius: true,
                                    isNetworkImage:
                                        product.productThumbnailImage != null,
                                    fit: BoxFit.cover,
                                    imgUrl:
                                        product.productThumbnailImage ??
                                        AppImages.placeholder,
                                  ),
                                  const Gap(AppSizes.md),
                                  AppCardContainer(
                                    width: 300 * 0.49,
                                    height: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => Get.toNamed(
                                            '/product/${product.slug}',
                                            parameters: {'prevRoute': '/cart'},
                                          ),
                                          child: Text(
                                            product.productName!,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Gap(AppSizes.spaceBtwSmallItem),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${cartController.allCartProducts[index].quantity} * ৳${cartController.allCartProducts[index].price}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.apply(
                                                    color: AppColors.darkerGrey,
                                                  ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                cartController
                                                    .deleteCartProduct(index);
                                              },
                                              child: const HugeIcon(
                                                icon: HugeIcons
                                                    .strokeRoundedDelete03,
                                                size: AppSizes.iconSm,
                                                color: AppColors.error,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const Gap(AppSizes.sm),

                              /// Quantity Buttons
                              AppCardContainer(
                                height: 60,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cartController.addQuantity(index);
                                      },
                                      child:
                                          !cartController.quantityUpdateApiIDs
                                              .contains(product.id)
                                          ? const HugeIcon(
                                              icon: HugeIcons
                                                  .strokeRoundedPlusSign,
                                              size: AppSizes.iconSm,
                                            )
                                          : const SizedBox(
                                              height: 10,
                                              width: 10,
                                              child: CircularProgressIndicator(
                                                color: AppColors.primary,
                                                strokeWidth: 1,
                                              ),
                                            ),
                                    ),
                                    AppCardContainer(
                                      height: 20,
                                      width: 20,
                                      borderRadius: AppSizes.borderRadiusSm,
                                      borderWidth: 1,
                                      hasBorder: true,
                                      borderColor: AppColors.secondary,
                                      child: Center(
                                        child: Text(
                                          product.quantity.toString(),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelMedium,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cartController.removeQuantity(index);
                                      },
                                      child:
                                          !cartController.quantityUpdateApiIDs
                                              .contains(product.id)
                                          ? const Icon(
                                              Icons.remove,
                                              size: AppSizes.iconSm,
                                            )
                                          : const SizedBox(
                                              height: 10,
                                              width: 10,
                                              child: CircularProgressIndicator(
                                                color: AppColors.primary,
                                                strokeWidth: 1,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            }),
          ),

          /// -------- FOOTER ----------
          Obx(() {
            return Visibility(
              visible: cartController.allCartProducts.isNotEmpty,
              child: Column(
                children: [
                  AppDividersStyle.fullFlatAppDivider,
                  const Gap(AppSizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal:",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "৳${cartController.cartItemTotalPrice.value}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const Gap(AppSizes.md),
                  AppButtons.largeFlatOutlineButton(
                    verticallyPadding: AppSizes.sm,
                    onPressed: () {
                      bottomNavController.pageIndex.value == 2
                          ? Get.back()
                          : bottomNavController.jumpToTab(2);
                    },
                    buttonText: "View Cart",
                  ),
                  AppButtons.largeFlatFilledButton(
                    verticallyPadding: AppSizes.sm,
                    backgroundColor: AppColors.secondary,
                    onPressed: () async {
                      CheckoutSummaryResponse? checkoutSummaryResponse =
                          await cartController.getCheckoutSummary();
                      if (checkoutSummaryResponse!.result == true) {
                        Get.to(() => CheckoutScreen());
                      }
                    },
                    buttonText: "Checkout",
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
