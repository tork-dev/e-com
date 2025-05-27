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
import '../../controller/home_controller.dart';

class HomeTrendingSection extends StatelessWidget {
  const HomeTrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    return Obx( () {
        return homeController.hittingApi.value? ShimmerHelper().buildListShimmer(itemCount: 3, itemHeight: 150):
        AppListViewLayout(
          itemCount: homeController.homeProductResponse.value.trending!.length,
          builderFunction:
              (context, index1) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
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
                            borderWidth: 1,
                            borderColor: AppColors.lightGrey,
                            hasBorder: true,
                            padding: EdgeInsets.all(AppSizes.sm),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppBannerImage(
                                  height: 100,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${homeController.homeProductResponse.value.trending?[index1].trendingProducts?[index2].name}",
                                        style:
                                            Theme.of(context).textTheme.titleLarge,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
                                            itemPadding: const EdgeInsets.only(
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
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color:
                                                                AppColors.darkGrey,
                                                          ),
                                                    ),
                                                    const Gap(AppSizes.sm),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "৳${homeController.homeProductResponse.value.trending?[index1].trendingProducts?[index2].salePrice}",
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge?.apply(
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Gap(AppSizes.sm),
                                          InkWell(
                                            onTap: () {},
                                            child: AppCardContainer(
                                              applyRadius: true,
                                              borderRadius: AppSizes.borderRadiusSm,
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    AppSizes.sm,
                                                vertical: AppSizes.xs,
                                              ),
                                              backgroundColor:
                                                  AppColors.addToCartButton,
                                              child: Text(
                                                "Add to cart",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .apply(color: AppColors.white),
                                              ),
                                            ),
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
                            RoutingHelper.urlRouting(homeController.homeProductResponse.value.trending?[1].categoryUrl);
                          },
                          buttonText: "View more",
                          backgroundColor: AppColors.secondary,
                        ),
                      ),
                      Gap(AppSizes.spaceBtwItems)
                    ],
                  ),
                ),
              ),
        );
      }
    );
  }
}
