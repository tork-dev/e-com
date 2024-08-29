import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:kirei/src/features/wishlist/repositories/wishlist_repositories.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class AppDetailsProductNamePart extends StatelessWidget {
  const AppDetailsProductNamePart({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsPageController.instance;
    return Obx(() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailsController.productDetails.value.detailedProducts == null
                    ? ShimmerHelper().buildBasicShimmer(height: 30)
                    : Text(
                        detailsController
                            .productDetails.value.detailedProducts!.name!,
                        style: Theme.of(context).textTheme.titleMedium),
                const Gap(AppSizes.spaceBtwDefaultItems),
                detailsController.productDetails.value.detailedProducts == null
                    ? ShimmerHelper().buildBasicShimmer(height: 30)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                RatingBar(
                                  itemSize: 18.0,
                                  ignoreGestures: true,
                                  initialRating: double.parse(detailsController
                                      .productDetails
                                      .value
                                      .detailedProducts!
                                      .ratings
                                      .toString()),
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star,
                                        color: Color(0xffffe234)),
                                    empty: const Icon(Icons.star,
                                        color:
                                            Color.fromRGBO(224, 224, 225, 1)),
                                    half: const Icon(Icons.star,
                                        color: Color.fromRGBO(192, 53, 50, 1)),
                                  ),
                                  itemPadding:
                                      const EdgeInsets.only(right: 1.0),
                                  onRatingUpdate: (double value) {},
                                ),
                                Text(
                                  ' (${detailsController.productDetails.value.detailedProducts!.reviews})',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(color: AppColors.darkGrey),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () async {
                                      final String link = detailsController
                                          .productDetails
                                          .value
                                          .detailedProducts!
                                          .productLink!;
                                      final result = await Share.share(link);
                                      if(result.status == ShareResultStatus.success){
                                        EventLogger().shareEvent(detailsController.productDetails.value.detailedProducts!.slug!);
                                      }

                                    },
                                    child: const Icon(Icons.share)),
                                const Gap(AppSizes.defaultSpace),
                                InkWell(onTap: () {
                                  if (AppLocalStorage().readData(
                                          LocalStorageKeys.isLoggedIn) ==
                                      true) {
                                    detailsController.checkWishList.value
                                                .isInWishlist ==
                                            false
                                        ? detailsController
                                            .getWishListAdd()
                                            .then((value) => {
                                                  EventLogger()
                                                      .logAddToWishlistEvent(
                                                          '${detailsController.productDetails.value.detailedProducts!.slug}',
                                                          detailsController
                                                              .productDetails
                                                              .value
                                                              .detailedProducts!
                                                              .salePrice),
                                                  detailsController
                                                      .checkWishListAdd(),
                                                  AppHelperFunctions.showToast(
                                                      detailsController
                                                          .addToWishlist
                                                          .value
                                                          .message!),
                                                })
                                        : detailsController
                                            .wishListRemove()
                                            .then((value) => {
                                                  detailsController
                                                      .checkWishListAdd(),
                                                  AppHelperFunctions.showToast(
                                                      detailsController
                                                          .removeFromWishList
                                                          .value
                                                          .message!),
                                                });
                                  } else {
                                    Get.to(() => const LogIn());
                                  }
                                }, child: Obx(() {
                                  return Icon(detailsController.checkWishList
                                              .value.isInWishlist ==
                                          true
                                      ? Icons.favorite
                                      : Icons.favorite_border);
                                }))
                              ],
                            ),
                          )
                        ],
                      ),
                const Gap(AppSizes.spaceBtwDefaultItems),
                detailsController.productDetails.value.detailedProducts == null
                    ? ShimmerHelper().buildBasicShimmer(height: 30)
                    : detailsController.productDetails.value.detailedProducts!
                            .productBrands!.isNotEmpty
                        ? Row(
                            children: [
                              Text(
                                'Brand: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: AppColors.darkGrey),
                              ),
                              const Gap(AppSizes.spaceBtwSections),
                              Text(
                                  detailsController
                                          .productDetails
                                          .value
                                          .detailedProducts
                                          ?.productBrands?[0]
                                          .name ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(color: AppColors.darkGrey))
                            ],
                          )
                        : const SizedBox()
              ],
            ),
          ),
          const Gap(AppSizes.spaceBtwDefaultItems),
          AppDividersStyle.fullFlatAppDivider,
          const Gap(AppSizes.spaceBtwDefaultItems),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailsController.productDetails.value.detailedProducts == null
                    ? ShimmerHelper().buildBasicShimmer(height: 30)
                    : Row(
                        children: [
                          Text(
                            'Price: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: AppColors.darkGrey),
                          ),
                          const Gap(AppSizes.spaceBtwSections),
                          Visibility(
                            visible: detailsController.productDetails.value
                                    .detailedProducts!.price !=
                                detailsController.productDetails.value
                                    .detailedProducts!.salePrice,
                            child: Row(
                              children: [
                                Text(
                                  '৳${detailsController.productDetails.value.detailedProducts!.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .apply(
                                          color: AppColors.darkGrey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                const Gap(AppSizes.spaceBtwSmallItem)
                              ],
                            ),
                          ),
                          Text(
                              '৳${detailsController.productDetails.value.detailedProducts!.salePrice}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .apply(color: AppColors.dark)),
                        ],
                      ),
                const Gap(AppSizes.spaceBtwDefaultItems),
                detailsController.productDetails.value.detailedProducts == null
                    ? ShimmerHelper().buildBasicShimmer(height: 30)
                    : Row(
                        children: [
                          Text(
                            'Quantity: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: AppColors.darkGrey),
                          ),
                          const Gap(AppSizes.spaceBtwSections),
                          SizedBox(
                            width: 100,
                            // height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () =>
                                        detailsController.onRemoveButtonTap(),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 30,
                                    )),
                                AppCardContainer(
                                    height: 30,
                                    width: 30,
                                    hasBorder: true,
                                    borderWidth: 1,
                                    applyRadius: false,
                                    child: Center(
                                      child: Text(
                                          '${detailsController.productCount.value}'),
                                    )),
                                InkWell(
                                  onTap: () =>
                                      detailsController.onAddButtonTap(),
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Gap(AppHelperFunctions.screenWidth() * 0.1),
                          Text(
                              detailsController
                                          .productDetails
                                          .value
                                          .detailedProducts!
                                          .preorderAvailable ==
                                      0
                                  ? detailsController.productDetails.value
                                              .detailedProducts!.stock !=
                                          0
                                      ? 'In Stock'
                                      : 'Stock Out'
                                  : 'Coming soon',
                              style:
                                  Theme.of(context).textTheme.titleLarge!.apply(
                                        color: detailsController
                                                    .productDetails
                                                    .value
                                                    .detailedProducts!
                                                    .preorderAvailable ==
                                                0
                                            ? detailsController
                                                        .productDetails
                                                        .value
                                                        .detailedProducts!
                                                        .stock !=
                                                    0
                                                ? Colors.green
                                                : AppColors.primary
                                            : Colors.orange,
                                      )),
                        ],
                      ),
              ],
            ),
          ),
          const Gap(AppSizes.spaceBtwDefaultItems),
          AppDividersStyle.fullFlatAppDivider
        ],
      );
    });
  }
}
