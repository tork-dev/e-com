import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/routing_helper.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/firebase/gtm_events.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/logging/logger.dart';
import '../../../bottom_navigation/convex_controller.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../../shop/controller/get_shop_data_controller.dart';
import '../../controller/home_controller.dart';

class HomeTrendingSection extends StatelessWidget {
  const HomeTrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final cartController = CartController.instance;
    final categoryPassingController = Get.put(GetShopDataController());
    final bottomController = ConvexBottomNavController.instance;
    return AppCardContainer(
      padding: EdgeInsets.symmetric(vertical: AppSizes.md),
      backgroundColor: AppColors.contentInversePrimary.withAlpha(28),
      child: Obx(() {
        return homeController.hittingApi.value
            ? ShimmerHelper().buildListShimmer(itemCount: 3, itemHeight: 150)
            : AppListViewLayout(
              itemCount:
                  homeController.homeProductResponse.value.trending!.length,
              builderFunction:
                  (context, index1) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                    ),
                    child: Visibility(
                      visible:
                          homeController
                              .homeProductResponse
                              .value
                              .trending![index1]
                              .trendingProducts!
                              .isNotEmpty,
                      child: Column(
                        children: [
                          AppSectionTitleText(
                            sectionTitle:
                                'Trending ${homeController.homeProductResponse.value.trending![index1].categoryName}',
                            haveTxtButton: false,
                          ),
                          AppListViewLayout(
                            itemCount:
                                homeController
                                    .homeProductResponse
                                    .value
                                    .trending![index1]
                                    .trendingProducts!
                                    .length,
                            builderFunction: (context, index2) {
                              return AppCardContainer(
                                onTap: () {
                                  Get.toNamed(
                                    "/product/${homeController.homeProductResponse.value.trending?[index1].trendingProducts?[index2].slug}",
                                  );
                                },
                                borderWidth: 1,
                                borderColor: AppColors.lightGrey,
                                hasBorder: true,
                                padding: EdgeInsets.all(AppSizes.sm),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppBannerImage(
                                      height: 110,
                                      width: 100,
                                      isNetworkImage: true,
                                      imgUrl:
                                          homeController
                                              .homeProductResponse
                                              .value
                                              .trending?[index1]
                                              .trendingProducts?[index2]
                                              .smallPictures?[0]
                                              .url,
                                    ),
                                    SizedBox(width: AppSizes.spaceBtwItems),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 48,
                                            child: Text(
                                              "${homeController.homeProductResponse.value.trending?[index1].trendingProducts?[index2].name}",
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.titleLarge,
                                              maxLines: 2,

                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Gap(AppSizes.sm),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RatingBar(
                                                itemSize: 12.0,
                                                ignoreGestures: true,
                                                initialRating:
                                                    homeController
                                                        .homeProductResponse
                                                        .value
                                                        .trending?[index1]
                                                        .trendingProducts?[index2]
                                                        .ratings
                                                        .toDouble()!,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                ratingWidget: RatingWidget(
                                                  full: const Icon(
                                                    Icons.star,
                                                    color: Color.fromRGBO(
                                                      192,
                                                      53,
                                                      50,
                                                      1,
                                                    ),
                                                  ),
                                                  empty: const Icon(
                                                    Icons.star,
                                                    color: Color.fromRGBO(
                                                      224,
                                                      224,
                                                      225,
                                                      1,
                                                    ),
                                                  ),
                                                  half: const Icon(
                                                    Icons.star,
                                                    color: Color.fromRGBO(
                                                      192,
                                                      53,
                                                      50,
                                                      1,
                                                    ),
                                                  ),
                                                ),
                                                itemPadding:
                                                    const EdgeInsets.only(
                                                      right: 1.0,
                                                    ),
                                                onRatingUpdate: (rating) {
                                                  //print(rating);
                                                },
                                              ),
                                              Gap(AppSizes.xs),
                                              Text(
                                                "(${homeController.homeProductResponse.value.trending?[index1].trendingProducts?[index2].reviews})",
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Gap(AppSizes.xs),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Visibility(
                                                    visible:
                                                        homeController
                                                            .homeProductResponse
                                                            .value
                                                            .trending?[index1]
                                                            .trendingProducts?[index2]
                                                            .salePrice !=
                                                        homeController
                                                            .homeProductResponse
                                                            .value
                                                            .trending?[index1]
                                                            .trendingProducts?[index2]
                                                            .price,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "৳${homeController.homeProductResponse.value.trending?[index1].trendingProducts?[index2].price}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          maxLines: 1,
                                                          style: Theme.of(
                                                                context,
                                                              )
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color:
                                                                    AppColors
                                                                        .darkGrey,
                                                              ),
                                                        ),
                                                        const Gap(AppSizes.sm),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "৳${homeController.homeProductResponse.value.trending?[index1].trendingProducts?[index2].salePrice}",
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.apply(
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const Gap(AppSizes.sm),
                                              InkWell(
                                                onTap: () {
                                                  final product =
                                                      homeController
                                                          .homeProductResponse
                                                          .value
                                                          .trending?[index1]
                                                          .trendingProducts?[index2];
                                                  if (AppLocalStorage()
                                                          .readData(
                                                            LocalStorageKeys
                                                                .isLoggedIn,
                                                          ) !=
                                                      null) {
                                                    if (product
                                                            ?.requestAvailable !=
                                                        0) {
                                                      cartController
                                                          .getRequestResponse(
                                                            productId:
                                                                product!.id!,
                                                          )
                                                          .then(
                                                            (
                                                              value,
                                                            ) => AppHelperFunctions.showToast(
                                                              cartController
                                                                  .requestStockResponse
                                                                  .value
                                                                  .message!,
                                                            ),
                                                          );
                                                      return;
                                                    }

                                                    cartController
                                                        .getAddToCartResponse(
                                                          product!.id!,
                                                          1,
                                                          product
                                                              .preorderAvailable,
                                                        );
                                                  } else {
                                                    Get.toNamed(
                                                      '/login/cart',
                                                      parameters: {
                                                        'product_id':
                                                            product!.id
                                                                .toString(),
                                                        'product_slug':
                                                            product.slug!,
                                                        'sale_price':
                                                            product.salePrice
                                                                .toString(),
                                                        'request_available':
                                                            product
                                                                .requestAvailable
                                                                .toString(),
                                                        'preorder_available':
                                                            product
                                                                .preorderAvailable
                                                                .toString(),
                                                      },
                                                    );
                                                  }

                                                  EventLogger()
                                                      .logAddToCartEvent(
                                                        '${product.slug}',
                                                        product.salePrice!,
                                                      );
                                                },
                                                child: Obx(() {
                                                  return AppCardContainer(
                                                    applyRadius: true,
                                                    borderRadius:
                                                        AppSizes.borderRadiusSm,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              AppSizes.sm,
                                                          vertical: AppSizes.sm,
                                                        ),
                                                    hasBorder: true,
                                                    borderWidth: 1,
                                                    backgroundColor:
                                                        homeController
                                                                    .homeProductResponse
                                                                    .value
                                                                    .trending?[index1]
                                                                    .trendingProducts?[index2]
                                                                    .stock !=
                                                                0
                                                            ? AppColors
                                                                .addToCartButton
                                                            : homeController
                                                                    .homeProductResponse
                                                                    .value
                                                                    .trending?[index1]
                                                                    .trendingProducts?[index2]
                                                                    .preorderAvailable ==
                                                                0
                                                            ? homeController
                                                                        .homeProductResponse
                                                                        .value
                                                                        .trending![index1]
                                                                        .trendingProducts![index2]
                                                                        .requestAvailable ==
                                                                    0
                                                                ? AppColors
                                                                    .primary
                                                                : AppColors
                                                                    .request
                                                            : AppColors
                                                                .preorder,
                                                    borderColor:
                                                        AppColors.borderPrimary,
                                                    child: Text(
                                                      homeController
                                                                  .homeProductResponse
                                                                  .value
                                                                  .trending?[index1]
                                                                  .trendingProducts?[index2]
                                                                  .stock !=
                                                              0
                                                          ? cartController
                                                                  .addingToCartIds
                                                                  .contains(
                                                                    homeController
                                                                        .homeProductResponse
                                                                        .value
                                                                        .trending?[index1]
                                                                        .trendingProducts?[index2]
                                                                        .id,
                                                                  )
                                                              ? "Adding..."
                                                              : 'Add to cart'
                                                          : homeController
                                                                  .homeProductResponse
                                                                  .value
                                                                  .trending?[index1]
                                                                  .trendingProducts?[index2]
                                                                  .preorderAvailable ==
                                                              0
                                                          ? homeController
                                                                      .homeProductResponse
                                                                      .value
                                                                      .trending![index1]
                                                                      .trendingProducts![index2]
                                                                      .requestAvailable ==
                                                                  0
                                                              ? 'Out of stock'
                                                              : "Request stock"
                                                          : 'Preorder now',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .apply(
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Gap(AppSizes.sm),
                          SizedBox(
                            width: 150,
                            child: AppButtons.largeFlatFilledButton(
                              onPressed: () {
                                categoryPassingController.getValuesFromUrl(
                                  homeController
                                      .homeProductResponse
                                      .value
                                      .trending![index1]
                                      .categoryUrl!,
                                );
                                bottomController.jumpToTab(1);
                              },
                              buttonText: "View more",
                              backgroundColor: AppColors.secondary,
                            ),
                          ),
                          Gap(AppSizes.spaceBtwItems),
                        ],
                      ),
                    ),
                  ),
            );
      }),
    );
  }
}
