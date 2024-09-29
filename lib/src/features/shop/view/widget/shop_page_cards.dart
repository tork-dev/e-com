import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/containers/vertical_product_card.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';

import '../../../../common/layouts/gridview_layout/gridview_layout.dart';
import '../../../../common/styles/app_dividers.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../authentication/views/log_in/view/login.dart';
import '../../../cart/controllers/cart_controller.dart';
import 'sub_category.dart';

class AppShopGridScrollCard extends StatelessWidget {
  const AppShopGridScrollCard({super.key});

  @override
  Widget build(BuildContext context) {
    final shopController = GetShopDataController.instance;
    final cartController = CartController.instance;
    return Obx(() {
      return !shopController.hittingApi.value &&
              shopController.allProducts.isEmpty
          ? SizedBox(
              height: AppHelperFunctions.screenHeight() * .8,
              child: const Center(
                child: Text('No product found'),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: shopController.isFromCategory.value,
                    child: Column(
                      children: [
                        const ShopSubCategory(),
                        AppDividersStyle.fullFlatAppDivider
                      ],
                    )),
                const Gap(AppSizes.sm),
                AppGridViewLayout(
                    itemCount: shopController.hittingApi.value
                        ? 10
                        : shopController.allProducts.length,
                    builderFunction: (context, index) => shopController
                            .hittingApi.value
                        ? ShimmerHelper()
                            .buildBasicShimmer(height: 150, width: 150)
                        : shopController.allProducts.isEmpty
                            ? const AppCardContainer(
                                height: 350,
                                backgroundColor: AppColors.addToCartButton,
                                child: Text('No Product Found'),
                              )
                            : AppVerticalProductCard(
                                imgHeight: 150,
                                imgWidth: double.infinity,
                                onTap: () {
                                  Get.toNamed(
                                      '/product/${shopController.allProducts[index].slug!}');
                                },
                                onCartTap: () {
                                  if (AppLocalStorage().readData(
                                          LocalStorageKeys.isLoggedIn) !=
                                      null) {
                                    EventLogger().logAddToCartEvent(
                                        shopController.allProducts[index].slug!,
                                        shopController
                                            .allProducts[index].salePrice);
                                    if (shopController.allProducts[index]
                                            .requestAvailable !=
                                        0) {
                                      cartController
                                          .getRequestResponse(
                                              productId: shopController
                                                  .allProducts[index].id!)
                                          .then((value) =>
                                              AppHelperFunctions.showToast(
                                                  cartController
                                                      .requestStockResponse
                                                      .value
                                                      .message!));
                                      return;
                                    }
                                    cartController
                                        .getAddToCartResponse(
                                            shopController
                                                .allProducts[index].id!,
                                            1,
                                            shopController.allProducts[index]
                                                .preorderAvailable)
                                        .then((value) => {
                                      if(cartController.addToCartResponse.value.result == true){
                                        cartController.cartCount.value =
                                            cartController.addToCartResponse.value
                                                .cartQuantity ?? 0,
                                      },
                                              AppHelperFunctions.showToast(
                                                  cartController
                                                      .addToCartResponse
                                                      .value
                                                      .message!)
                                            });
                                  } else {
                                    Get.to(() => const LogIn());
                                  }
                                },
                                productName:
                                    shopController.allProducts[index].name ??
                                        '',
                                ratings: shopController
                                    .allProducts[index].ratings!
                                    .toDouble(),
                                imgUrl: shopController
                                        .allProducts[index].pictures![0].url ??
                                    '',
                                reviews:
                                    shopController.allProducts[index].reviews ??
                                        0,
                                salePrice: shopController
                                        .allProducts[index].salePrice
                                        ?.toInt() ??
                                    0,
                                price: shopController.allProducts[index].price
                                        ?.toInt() ??
                                    0,
                                buttonName:
                                    shopController.allProducts[index].stock != 0
                                        ? 'ADD TO CART'
                                        : shopController.allProducts[index]
                                                    .preorderAvailable ==
                                                0
                                            ? shopController.allProducts[index]
                                                        .requestAvailable !=
                                                    0
                                                ? "REQUEST FOR STOCK"
                                                : "OUT OF STOCK"
                                            : "PREORDER NOW",
                                backgroundColor:
                                    shopController.allProducts[index].stock != 0
                                        ? AppColors.secondary
                                        : shopController.allProducts[index]
                                                    .preorderAvailable ==
                                                0
                                            ? shopController.allProducts[index]
                                                        .requestAvailable !=
                                                    0
                                                ? AppColors.request
                                                : AppColors.primary
                                            : AppColors.preorder,
                                isDiscountAvailable: shopController
                                        .allProducts[index].salePrice !=
                                    shopController.allProducts[index].price,
                                isNetworkImage: true,
                                discount: shopController
                                        .allProducts[index].discount!
                                        .toInt() ??
                                    0,
                                isStockAvailable:
                                    shopController.allProducts[index].stock !=
                                        0,
                                buttonColor: AppColors.white,
                              )),
              ],
            );
    });
  }
}
