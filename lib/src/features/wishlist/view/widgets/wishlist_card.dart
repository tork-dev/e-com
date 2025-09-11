import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class AppWishListProductCard extends StatelessWidget {
  const AppWishListProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = WishlistController.instance;
    final cartController = Get.put(CartController());
    return Obx(() {
      return AppListViewLayout(
        itemCount:
            wishlistController.apiHitting.value
                ? 10
                : wishlistController.wishlistProducts.value.data!.length,
        builderFunction: (context, index) {
          return wishlistController.apiHitting.value
              ? ShimmerHelper().buildBasicShimmer(height: 120)
              : AppCardContainer(
                hasBorder: true,
                borderColor: AppColors.grey,
                padding: const EdgeInsets.all(AppSizes.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppBannerImage(
                          width: 90,
                          height: 90,
                          isNetworkImage: true,
                          imgUrl:
                              wishlistController
                                  .wishlistProducts
                                  .value
                                  .data![index]
                                  .product!
                                  .pictures![0].url ??
                              '',
                        ),
                        const Gap(AppSizes.sm),
                        SizedBox(
                          width: AppHelperFunctions.screenWidth() * .4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${wishlistController.wishlistProducts.value.data![index].product!.name}',
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(AppSizes.md),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${wishlistController.wishlistProducts.value.data![index].product!.price}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    wishlistController
                                                .wishlistProducts
                                                .value
                                                .data![index]
                                                .product!
                                                .stock !=
                                            0
                                        ? 'In Stock'
                                        : wishlistController
                                                .wishlistProducts
                                                .value
                                                .data![index]
                                                .product!
                                                .preorderAvailable !=
                                            1
                                        ? 'Stock out'
                                        : 'Preorder',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.apply(
                                      color:
                                          wishlistController
                                                      .wishlistProducts
                                                      .value
                                                      .data![index]
                                                      .product!
                                                      .stock !=
                                                  0
                                              ? AppColors.inStock
                                              : wishlistController
                                                      .wishlistProducts
                                                      .value
                                                      .data![index]
                                                      .product!
                                                      .preorderAvailable !=
                                                  1
                                              ? AppColors.error
                                              : AppColors.preorder,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: AppHelperFunctions.screenWidth() * .1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              cartController
                                  .getAddToCartResponse(
                                    wishlistController
                                        .wishlistProducts
                                        .value
                                        .data![index]
                                        .product!
                                  )
                                  .then(
                                    (value) => {
                                          wishlistController
                                              .isAddedToCart
                                              .value = true,

                                    },
                                  );
                            },
                            child: const Icon(
                              Icons.shopping_cart_checkout,
                              color: AppColors.darkGrey,
                            ),
                          ),
                          const Gap(AppSizes.lg),
                          InkWell(
                            onTap: () {
                              wishlistController
                                  .deleteWishlistProducts(
                                    wishlistController
                                        .wishlistProducts
                                        .value
                                        .data![index]
                                        .id!,
                                  )
                                  .then(
                                    (value) =>
                                        wishlistController.onRefresh().then(
                                          (
                                            value,
                                          ) => AppHelperFunctions.showToast(
                                            wishlistController
                                                .removeWishlistProductsResponse
                                                .value
                                                .message!,
                                          ),
                                        ),
                                  );
                            },
                            child: const Icon(
                              Icons.delete_forever_outlined,
                              color: AppColors.darkGrey,
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
    });
  }
}
