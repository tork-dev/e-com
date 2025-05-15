import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../common/layouts/layout_with_refresher/layout_with_refresher.dart';
import '../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../common/styles/skeleton_style.dart';
import '../../../common/widgets/containers/vertical_product_card.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/firebase/gtm_events.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../bottom_navigation/convex_bottom_navigation.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controller/recommendation_controller.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final RecommendationController recommendationController = Get.put(
      RecommendationController(),
    );
    final CartController cartController = Get.put(CartController());

    return AppLayoutWithBackButton(
      backToHome: true,
      canPop: false,
      padding: AppSizes.md,
      title: Text(
        'AI Recommendation',
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.apply(color: AppColors.backLayoutAppBarTitle),
      ),
      centerTitle: true,
      leadingIconColor: AppColors.darkGrey,
      showBackButton: false,
      customLeadingIcon: Icons.arrow_back_ios_new_rounded,
      showCustomLeading: true,
      leadingOnPress: () {
        Get.offAll(() => const HelloConvexAppBar());
      },
      body: Obx(() {
        // Displaying shimmer while loading data
        if (recommendationController.apiHitting.value) {
          return ShimmerHelper().buildProductGridShimmer();
        }

        return AppLayoutWithRefresher(
          onRefresh: recommendationController.onRefresh,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  recommendationController.productResponse.value.data!.map((
                    productData,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recommendation For ${productData.type!}",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Gap(AppSizes.sm),
                        SizedBox(
                          height: 280,
                          // Provide explicit height for horizontally scrollable list
                          child: AppListViewLayout(
                            isScrollVertically:
                                false, // Ensure horizontal scroll
                            itemCount: productData.products!.length,
                            builderFunction: (context, index) {
                              final product = productData.products![index];

                              // Handle possible null values safely
                              return AppVerticalProductCard(
                                height: 270,
                                width: 150,
                                imgUrl:
                                    product.pictures?.isNotEmpty == true
                                        ? product.pictures![0].url ?? ''
                                        : '',
                                onTap: () {
                                  Get.toNamed(
                                    '/product/${product.slug}',
                                    parameters: {
                                      'prevRoute':
                                          '/recommended-products?${recommendationController.buildQueryParams()}',
                                    },
                                  );

                                  EventLogger().logProductDetailsViewEvent(
                                    '${product.slug}',
                                  );
                                },
                                onCartTap: () {
                                  if (product.requestAvailable != 0) {
                                    cartController
                                        .getRequestResponse(
                                          productId: product.id!,
                                        )
                                        .then((value) {
                                          AppHelperFunctions.showToast(
                                            cartController
                                                    .requestStockResponse
                                                    .value
                                                    .message ??
                                                'Stock request submitted.',
                                          );
                                        });
                                    return;
                                  }
                                  cartController
                                      .getAddToCartResponse(
                                        product.id!,
                                        1,
                                        product.preorderAvailable,
                                      )
                                      .then((value) {
                                        cartController.cartCount.value =
                                            cartController
                                                .addToCartResponse
                                                .value
                                                .cartQuantity ??
                                            0;
                                        AppHelperFunctions.showToast(
                                          cartController
                                                  .addToCartResponse
                                                  .value
                                                  .message ??
                                              'Added to cart.',
                                        );
                                      });

                                  EventLogger().logAddToCartEvent(
                                    '${product.slug}',
                                    product.salePrice!,
                                  );
                                },
                                productName: product.name ?? 'Unnamed Product',
                                ratings: double.parse(
                                  "${product.ratings ?? 0}",
                                ),
                                reviews: product.reviews ?? 0,
                                salePrice: product.salePrice ?? 0,
                                price: product.price ?? 0,
                                buttonName:
                                    product.stock != 0
                                        ? "Add To cart"
                                        : product.preorderAvailable != 0
                                        ? "Preorder now"
                                        : product.requestAvailable != 0
                                        ? "Request stock"
                                        : "Out of stock",
                                backgroundColor:
                                    product.stock != 0
                                        ? AppColors.addToCartButton
                                        : product.preorderAvailable != 0
                                        ? AppColors.preorder
                                        : product.requestAvailable != 0
                                        ? AppColors.request
                                        : AppColors.primary,
                                isNetworkImage: true,
                                isDiscountAvailable:
                                    product.salePrice != product.price,
                                discount: product.discount ?? 0,
                                buttonColor: AppColors.white,
                                isStockAvailable: true,
                              );
                            },
                          ),
                        ),
                        const Gap(AppSizes.spaceBtwDefaultItems),
                      ],
                    );
                  }).toList(),
            ),
          ],
        );
      }),
    );
  }
}
