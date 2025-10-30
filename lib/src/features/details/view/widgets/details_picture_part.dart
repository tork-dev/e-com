import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class AppDetailsPicturePart extends StatelessWidget {
  const AppDetailsPicturePart({super.key});

  @override
  Widget build(BuildContext context) {
    DetailsPageController detailsController = DetailsPageController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: Obx(() {
        return SizedBox(
          height: 200,
          width: AppHelperFunctions.screenWidth() * 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: AppListViewLayout(
                  isScrollVertically: true,
                  itemCount:
                      detailsController.productDetails.value.detailedProducts ==
                              null
                          ? 3
                          : detailsController
                              .productDetails
                              .value
                              .detailedProducts!
                              .pictures!
                              .length,
                  builderFunction:
                      (BuildContext context, int index) =>
                          detailsController
                                      .productDetails
                                      .value
                                      .detailedProducts ==
                                  null
                              ? ShimmerHelper().buildBasicShimmer(
                                height: 50,
                                width: 50,
                              )
                              : InkWell(
                                onTap: () {
                                  detailsController.getLargePicture(index);
                                },
                                child: AppBannerImage(
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                  hasBorder:
                                      detailsController.pictureIndex.value ==
                                      index,
                                  borderWidth: 2,
                                  borderColor: AppColors.secondary,
                                  boarderRadius: 8,
                                  isNetworkImage: true,
                                  imgUrl:
                                      detailsController
                                          .productDetails
                                          .value
                                          .detailedProducts!
                                          .pictures![index]
                                          .url!,
                                ),
                              ),
                ),
              ),
              const Gap(AppSizes.spaceBtwSections),
              detailsController.productDetails.value.detailedProducts == null
                  ? ShimmerHelper().buildBasicShimmer(
                    height: 200,
                    width: AppHelperFunctions.screenWidth() * .63,
                  )
                  : SizedBox(
                    width: AppHelperFunctions.screenWidth() * .63,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: InstaImageViewer(
                            backgroundColor: Colors.transparent,
                            imageUrl:
                                detailsController
                                    .productDetails
                                    .value
                                    .detailedProducts!
                                    .pictures![detailsController
                                        .pictureIndex
                                        .value]
                                    .url!,
                            child: Material(
                              color: Colors.transparent,
                              child: AppBannerImage(
                                fit: BoxFit.cover,
                                isNetworkImage: true,
                                backgroundColor: Colors.transparent,
                                imgUrl:
                                    detailsController
                                        .productDetails
                                        .value
                                        .detailedProducts!
                                        .pictures![detailsController
                                            .pictureIndex
                                            .value]
                                        .url!,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Visibility(
                            visible:
                                detailsController
                                    .productDetails
                                    .value
                                    .detailedProducts
                                    ?.isHot ==
                                1,
                            child: AppCardContainer(
                              width: AppHelperFunctions.screenWidth() * .63,
                              borderRadius: AppSizes.borderRadiusSm,
                              gradient: LinearGradient(
                                colors: [AppColors.primary, Colors.red],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.sm,
                                horizontal: AppSizes.sm,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sale \nEnd's in",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.copyWith(
                                      color: AppColors.white,
                                      height: 1,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/icons/flash.png",
                                        height: 24,
                                        width: 24,
                                      ),
                                      TimerCountdown(
                                        format:
                                            CountDownTimerFormat
                                                .daysHoursMinutesSeconds,
                                        descriptionTextStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.apply(color: AppColors.white),
                                        timeTextStyle: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.copyWith(
                                          color: AppColors.white,
                                          height: .5,
                                        ),
                                        colonsTextStyle: Theme.of(
                                          context,
                                        ).textTheme.labelSmall!.copyWith(
                                          fontSize: 0,
                                          color: AppColors.textPrimary,
                                        ),
                                        daysDescription: 'Day',
                                        hoursDescription: 'Hour',
                                        minutesDescription: 'Min',
                                        secondsDescription: 'Sec',
                                        spacerWidth: 2,
                                        endTime:
                                            detailsController
                                                .productDetails
                                                .value
                                                .detailedProducts
                                                ?.flashSaleEndDate ??
                                            DateTime.now().add(
                                              const Duration(days: 1),
                                            ),
                                        onEnd: () {
                                          debugPrint("Timer finished");
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        );
      }),
    );
  }
}
