import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../utils/constants/image_strings.dart';
import 'package:carousel_slider/carousel_slider.dart' as cw;


class HomeReviewSection extends StatelessWidget {
  const HomeReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    return Obx(() {
      return AppCardContainer(
        applyRadius: false,
        padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultSpace, horizontal: AppSizes.md),
        backgroundColor: AppColors.whitePink,
        child: Column(
          children: [
            const AppSectionTitleText(
              sectionTitle: 'What our customers say',
              haveTxtButton: false,
            ),
        cw.CarouselSlider(
          options: cw.CarouselOptions(
            height: 220,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            autoPlay: true,
          ),
          items: List.generate(
            homeController.hittingApi.value
                ? 5
                : homeController.homeProductResponse.value.reviews!.length,
                (index) {
                  return AppCardContainer(
                      applyRadius: true,
                      backgroundColor: AppColors.white,
                      padding: const EdgeInsets.all(AppSizes.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scaleX: -1, // Negative scale flips horizontally
                            scaleY: -1,
                            child: Icon(Icons.format_quote_sharp, size: AppSizes.iconLg, color: AppColors.primary.withAlpha(72),),
                          ),
                          Expanded(
                            child: homeController.hittingApi.value
                                ? ShimmerHelper().buildBasicShimmer(
                                height: 100, width: 300)
                                : Text(
                              homeController.homeProductResponse.value
                                  .reviews![index].comment ??
                                  '',
                              style:
                              Theme.of(context).textTheme.titleSmall,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Row(
                            children: [
                              AppBannerImage(
                                  width: 50,
                                  height: 50,
                                  isNetworkImage: true,
                                  hasBorder: homeController
                                      .homeProductResponse
                                      .value
                                      .reviews![index]
                                      .avatar != null,
                                  borderColor: AppColors.primary,
                                  borderWidth: 1,
                                  boarderRadius: 100,
                                  imgBoarderRadius: 100,
                                  errorImage: AppImages.demoPerson,
                                  imgUrl: homeController
                                      .homeProductResponse
                                      .value
                                      .reviews![index]
                                      .avatar ?? ''),
                              const Gap(AppSizes.sm),
                              Text(
                                homeController.homeProductResponse.value
                                    .reviews![index].userName ??
                                    '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge?.apply(color: AppColors.darkerGrey),
                              ),
                            ],
                          ),
                        ],
                      ));
            },
          ),
        ),
            // SizedBox(
            //   height: 220,
            //     child: AppListViewLayout(
            //         itemCount: homeController.hittingApi.value
            //             ? 5
            //             : homeController
            //                 .homeProductResponse.value.reviews!.length,
            //         isScrollVertically: false,
            //         builderFunction: (context, index) {
            //           return AppCardContainer(
            //               width: 280,
            //               applyRadius: true,
            //               backgroundColor: AppColors.white,
            //               padding: const EdgeInsets.all(AppSizes.md),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Transform.scale(
            //                     scaleX: -1, // Negative scale flips horizontally
            //                     scaleY: -1,
            //                     child: Icon(Icons.format_quote_sharp, size: AppSizes.iconLg, color: AppColors.primary.withAlpha(72),),
            //                   ),
            //                   Expanded(
            //                     child: homeController.hittingApi.value
            //                         ? ShimmerHelper().buildBasicShimmer(
            //                             height: 100, width: 300)
            //                         : Text(
            //                             homeController.homeProductResponse.value
            //                                     .reviews![index].comment ??
            //                                 '',
            //                             style:
            //                                 Theme.of(context).textTheme.titleSmall,
            //                             maxLines: 4,
            //                             overflow: TextOverflow.ellipsis,
            //                           ),
            //                   ),
            //
            //                   Row(
            //                     children: [
            //                       AppBannerImage(
            //                           width: 48,
            //                           height: 48,
            //                           isNetworkImage: true,
            //                           hasBorder: homeController
            //                               .homeProductResponse
            //                               .value
            //                               .reviews![index]
            //                               .avatar != null,
            //                           borderColor: AppColors.primary,
            //                           borderWidth: 1,
            //                           boarderRadius: 100,
            //                           imgBoarderRadius: 100,
            //                           errorImage: AppImages.avatarIcon,
            //                           imgUrl: homeController
            //                           .homeProductResponse
            //                           .value
            //                           .reviews![index]
            //                           .avatar ?? ''),
            //                       const Gap(AppSizes.sm),
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Text(
            //                             homeController.homeProductResponse.value
            //                                 .reviews![index].userName ??
            //                                 '',
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .titleLarge,
            //                           ),
            //                           Text(
            //                             "${homeController.homeProductResponse.value.reviews![index].time}",
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .labelMedium,
            //                           )
            //                         ],
            //                       )
            //                     ],
            //                   ),
            //                 ],
            //               ));
            //         }),
            // )
          ],
        ),
      );
    });
  }
}
