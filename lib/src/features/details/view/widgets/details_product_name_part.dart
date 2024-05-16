import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';
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
                const Gap(AppSizes.spaceBtwItems),
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
                          const SizedBox(
                            child: Row(
                              children: [
                                Icon(Icons.share),
                                Gap(AppSizes.spaceBtwItems),
                                Icon(Icons.favorite_border)
                              ],
                            ),
                          )
                        ],
                      ),
                const Gap(AppSizes.spaceBtwItems),
                detailsController.productDetails.value.detailedProducts == null
                    ? ShimmerHelper().buildBasicShimmer(height: 30)
                    :  detailsController.productDetails.value
                    .detailedProducts!.productBrands!.isNotEmpty ?
                Row(
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
                      ) : const SizedBox()
              ],
            ),
          ),
          const Gap(AppSizes.spaceBtwItems),
          AppDividersStyle.fullFlatAppDivider,
          const Gap(AppSizes.spaceBtwItems),
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
                                const Gap(AppSizes.spaceBtwRowItem)
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
                const Gap(AppSizes.spaceBtwItems),
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
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.remove,
                                      size: 30,
                                    )),
                                const AppCardContainer(
                                    height: 30,
                                    width: 30,
                                    hasBorder: true,
                                    borderWidth: 1,
                                    applyRadius: false,
                                    child: Center(
                                      child: Text('1'),
                                    )),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Gap(80),
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
          const Gap(AppSizes.spaceBtwItems),
          AppDividersStyle.fullFlatAppDivider
        ],
      );
    });
  }
}
