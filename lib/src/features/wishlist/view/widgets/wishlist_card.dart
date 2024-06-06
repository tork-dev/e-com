import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/cart/controllers/cart_controller.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class AppWishListProductCard extends StatelessWidget {
  const AppWishListProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = WishlistController.instance;
    final cartController = HomeController.instance;
    return Obx(() {
      return AppListViewLayout(
          itemCount: wishlistController.wishlistProducts.value.data == null
              ? 10
              : wishlistController.wishlistProducts.value.data!.length,
          builderFunction: (context, index) {
            return wishlistController.wishlistProducts.value.data == null
                ? ShimmerHelper().buildBasicShimmer(height: 120)
                : AppCardContainer(
                    hasBorder: true,
                    borderColor: AppColors.grey,
                    padding: const EdgeInsets.all(AppSizes.sm),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBannerImage(
                            width: 90,
                            height: 90,
                            applyImageRadius: false,
                            isNetworkImage: true,
                            imgUrl: wishlistController.wishlistProducts.value
                                .data![index].product!.thumbnailImage!),
                        const Gap(AppSizes.sm),
                        SizedBox(
                          width: AppHelperFunctions.screenWidth() * .5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    '${wishlistController.wishlistProducts.value.data![index].product!.basePrice}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    wishlistController.wishlistProducts.value
                                                .data![index].product!.stock !=
                                            0
                                        ? 'In Stock'
                                        : wishlistController
                                                    .wishlistProducts
                                                    .value
                                                    .data![index]
                                                    .product!
                                                    .preorderAvailable !=
                                                0
                                            ? 'Stock out'
                                            : 'Preorder Available',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .apply(
                                            color: wishlistController
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
                                                        0
                                                    ? AppColors.error
                                                    : AppColors.preorder),
                                  )
                                ],
                              )
                            ],
                          ),
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
                                                .id!,
                                            1,
                                            wishlistController
                                                .wishlistProducts
                                                .value
                                                .data![index]
                                                .product!
                                                .preorderAvailable)
                                        .then((value) => {
                                              AppHelperFunctions.showToast(
                                                  cartController
                                                      .addToCartResponse
                                                      .value
                                                      .message!),
                                      if(cartController.addToCartResponse.value.result == true){
                                        wishlistController.isAddedToCart.value = true
                                      }
                                            });
                                  },
                                  child: const Icon(
                                    Icons.shopping_cart_checkout,
                                    color: AppColors.darkGrey,
                                  )),
                              const Gap(AppSizes.lg),
                              InkWell(
                                  onTap: () {
                                    wishlistController
                                        .deleteWishlistProducts(
                                            wishlistController
                                                .wishlistProducts
                                                .value
                                                .data![index]
                                                .product!
                                                .id!)
                                        .then((value) => wishlistController
                                            .onRefresh()
                                            .then((value) => AppHelperFunctions
                                                .showToast(wishlistController
                                                    .removeWishlistProductsResponse
                                                    .value
                                                    .message!)));
                                  },
                                  child: const Icon(
                                      Icons.delete_forever_outlined,
                                      color: AppColors.darkGrey))
                            ],
                          ),
                        )
                      ],
                    ));
          });
    });
  }
}
