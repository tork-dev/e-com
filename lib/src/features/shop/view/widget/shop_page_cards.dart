import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/containers/vertical_product_card.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../common/layouts/gridview_layout/gridview_layout.dart';
import '../../../../common/styles/app_dividers.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../cart/controllers/cart_controller.dart';
import 'sub_category.dart';

class AppShopGridScrollCard extends StatelessWidget {
  const AppShopGridScrollCard({super.key});

  @override
  Widget build(BuildContext context) {
    final shopController = GetShopDataController.instance;
    final bottomController = ConvexBottomNavController.instance;
    return Obx(() {
      final isLoadingMore = shopController.isLoadingMore.value;

      return !shopController.hittingApi.value &&
              shopController.allProducts.isEmpty
          ? SizedBox(
              height: AppHelperFunctions.screenHeight() * .8,
              child: const Center(child: Text('No product found')),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: shopController.isFromCategory.value,
                  child: Column(
                    children: [
                      const ShopSubCategory(),
                      AppDividersStyle.fullFlatAppDivider,
                    ],
                  ),
                ),
                const Gap(AppSizes.sm),
                AppGridViewLayout(
                  itemCount: shopController.hittingApi.value
                      ? 10
                      : shopController.allProducts.length,
                  builderFunction: (context, index) =>
                      shopController.hittingApi.value
                      ? ShimmerHelper().buildBasicShimmer(
                          height: 150,
                          width: 150,
                        )
                      : shopController.allProducts.isEmpty
                      ? AppCardContainer(
                          height: 350,
                          backgroundColor: AppColors.addToCartButton,
                          child: Text(
                            'No Product Found',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )
                      : GetBuilder<CartController>(
                          builder: (cartController) {
                            return AppVerticalProductCard(
                              imgHeight: 180,
                              imgWidth: double.infinity,
                              onTap: () {
                                Get.toNamed(
                                  '/product/${shopController.allProducts[index].slug!}',
                                  parameters: {
                                    'prevRoute':
                                        '/shop?${shopController.queryStringValue.value}',
                                  },
                                );
                              },
                              onCartTap: () {
                                cartController.allCartProducts.any(
                                      (element) =>
                                          element.productId ==
                                          shopController.allProducts[index].id,
                                    )
                                    ? bottomController.jumpToTab(2)
                                    : cartController.getAddToCartResponse(
                                        shopController.allProducts[index],
                                      );
                              },
                              productName:
                                  shopController.allProducts[index].name ?? '',
                              ratings: shopController
                                  .allProducts[index]
                                  .ratings!
                                  .toDouble(),
                              imgUrl:
                                  shopController
                                          .allProducts[index]
                                          .pictures
                                          ?.isNotEmpty ==
                                      true
                                  ? shopController
                                            .allProducts[index]
                                            .pictures!
                                            .first
                                            .url ??
                                        ''
                                  : '',

                              reviews:
                                  shopController.allProducts[index].reviews ??
                                  0,
                              salePrice:
                                  shopController.allProducts[index].salePrice
                                      ?.toInt() ??
                                  0,
                              price:
                                  shopController.allProducts[index].price
                                      ?.toInt() ??
                                  0,
                              buttonName:
                                  cartController.allCartProducts.any(
                                    (element) =>
                                        element.productId ==
                                        shopController.allProducts[index].id,
                                  )
                                  ? 'View Cart'
                                  : shopController.allProducts[index].stock != 0
                                  ? cartController.addingToCartIds.contains(
                                          shopController.allProducts[index].id,
                                        )
                                        ? "Adding..."
                                        : 'Add to cart'
                                  : shopController
                                            .allProducts[index]
                                            .preorderAvailable ==
                                        0
                                  ? shopController
                                                .allProducts[index]
                                                .requestAvailable !=
                                            0
                                        ? "Request stock"
                                        : "Out of stock"
                                  : "Preorder Now",
                              backgroundColor:
                                  shopController.allProducts[index].stock != 0
                                  ? AppColors.secondary
                                  : shopController
                                            .allProducts[index]
                                            .preorderAvailable ==
                                        0
                                  ? shopController
                                                .allProducts[index]
                                                .requestAvailable !=
                                            0
                                        ? AppColors.request
                                        : AppColors.primary
                                  : AppColors.preorder,
                              isDiscountAvailable:
                                  shopController.allProducts[index].salePrice !=
                                  shopController.allProducts[index].price,
                              isNetworkImage: true,
                              discount: shopController
                                  .allProducts[index]
                                  .discount!
                                  .toInt(),
                              isStockAvailable:
                                  shopController.allProducts[index].stock != 0,
                              buttonColor: AppColors.white,
                            );
                          },
                        ),
                ),
                // Loading indicator for pagination
                if (isLoadingMore)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                const Gap(AppSizes.md),
              ],
            );
    });
  }
}
