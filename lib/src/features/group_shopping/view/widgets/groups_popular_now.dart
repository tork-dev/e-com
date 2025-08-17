import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/features/group_shopping/controller/group_shopping_controller.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../../../utils/constants/app_api_end_points.dart';
import '../../../../utils/constants/colors.dart';

class GroupShoppingPopularNowGroups extends StatelessWidget {
  const GroupShoppingPopularNowGroups({super.key});

  @override
  Widget build(BuildContext context) {
    final groupShoppingController = GroupShoppingController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionTitleText(
            sectionTitle: 'Most popular group',
            haveTxtButton: false,
          ),
          const Gap(AppSizes.spaceBtwDefaultItems),
          Obx(() {
            return !groupShoppingController.hittingGroupApi.value &&
                    groupShoppingController
                        .groupShoppingGroup
                        .value
                        .popular!
                        .isEmpty
                ? Center(
                  child: Column(
                    children: [
                      Text(
                        'No Group Found',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
                : SizedBox(
                  height: 375,
                  child: AppListViewLayout(
                    itemCount:
                        groupShoppingController.hittingGroupApi.value
                            ? 5
                            : groupShoppingController
                                .groupShoppingGroup
                                .value
                                .popular!
                                .length,
                    isScrollVertically: false,
                    builderFunction: (context, index) {
                      return groupShoppingController.hittingGroupApi.value
                          ? ShimmerHelper().buildBasicShimmer(width: 200)
                          : AppCardContainer(
                            applyShadow: true,
                            width: 221,
                            backgroundColor: AppColors.white,
                            padding: const EdgeInsets.all(AppSizes.sm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    AppBannerImage(
                                      height: 120,
                                      width: 215,
                                      fit: BoxFit.contain,
                                      imgUrl:
                                          groupShoppingController
                                              .groupShoppingGroup
                                              .value
                                              .popular![index]
                                              .product
                                              ?.thumbnailImage ??
                                          '',
                                      isNetworkImage: true,
                                    ),
                                    Positioned(
                                      top: 4,
                                      child: AppCardContainer(
                                        borderRadius: AppSizes.cardRadiusXs,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.sm,
                                          vertical: AppSizes.xs,
                                        ),
                                        backgroundColor: AppColors.primary,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Duration: ",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelSmall!.apply(
                                                color: AppColors.white,
                                              ),
                                            ),
                                            SlideCountdown(
                                              duration: Duration(
                                                days:
                                                    groupShoppingController
                                                        .groupShoppingGroup
                                                        .value
                                                        .popular![index]
                                                        .expiredAt!
                                                        .day -
                                                    DateTime.now().day,
                                                hours:
                                                    groupShoppingController
                                                        .groupShoppingGroup
                                                        .value
                                                        .popular![index]
                                                        .expiredAt!
                                                        .hour -
                                                    DateTime.now().hour,
                                                minutes:
                                                    groupShoppingController
                                                        .groupShoppingGroup
                                                        .value
                                                        .popular![index]
                                                        .expiredAt!
                                                        .minute -
                                                    DateTime.now().minute,
                                                seconds:
                                                    groupShoppingController
                                                        .groupShoppingGroup
                                                        .value
                                                        .popular![index]
                                                        .expiredAt!
                                                        .second -
                                                    DateTime.now().second,
                                              ),
                                              decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              durationTitle:
                                                  const DurationTitle(
                                                    days: "d ",
                                                    hours: "h ",
                                                    minutes: "m ",
                                                    seconds: "s",
                                                  ),
                                              separatorPadding: EdgeInsets.zero,
                                              separatorType:
                                                  SeparatorType.title,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelSmall!.apply(
                                                color: AppColors.white,
                                              ),
                                              separatorStyle: Theme.of(
                                                context,
                                              ).textTheme.labelSmall!.apply(
                                                color: AppColors.white,
                                              ),
                                              padding: EdgeInsets.zero,
                                              shouldShowMinutes:
                                                  (duration) => true,
                                              // duration.inDays ==
                                              //     0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(AppSizes.spaceBtwDefaultItems),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: true,
                                      child: Row(
                                        children: [
                                          Text(
                                            "৳${groupShoppingController.groupShoppingGroup.value.popular![index].product?.price ?? 0}",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: AppColors.darkGrey,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Gap(AppSizes.sm),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "৳${groupShoppingController.groupShoppingGroup.value.popular![index].groupPurchasePrice ?? 0}",
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Text(
                                    groupShoppingController
                                            .groupShoppingGroup
                                            .value
                                            .popular![index]
                                            .product
                                            ?.name ??
                                        '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Gap(AppSizes.sm),
                                SizedBox(
                                  width: 205,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppBannerImage(
                                        height: 30,
                                        width: 30,
                                        applyImageRadius: true,
                                        isNetworkImage:
                                            groupShoppingController
                                                .groupShoppingGroup
                                                .value
                                                .popular![index]
                                                .groupAdmin
                                                ?.avatar !=
                                            null,
                                        imgUrl:
                                            groupShoppingController
                                                .groupShoppingGroup
                                                .value
                                                .popular![index]
                                                .groupAdmin
                                                ?.avatar ??
                                            AppImages.avatarIcon,
                                      ),
                                      const Gap(AppSizes.sm),
                                      Expanded(
                                        // Use Expanded to allow RichText to use remaining space
                                        child: RichText(
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          // Adds ellipsis if the text is too long
                                          text: TextSpan(
                                            text: 'Created by ',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelMedium!.apply(
                                              color: AppColors.secondary,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    groupShoppingController
                                                        .groupShoppingGroup
                                                        .value
                                                        .popular![index]
                                                        .groupAdmin
                                                        ?.name ??
                                                    '',
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Joined Members',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.labelMedium,
                                    ),
                                    Text(
                                      '${groupShoppingController.groupShoppingGroup.value.popular![index].currentUserQuantity} / ${groupShoppingController.groupShoppingGroup.value.popular![index].totalUserQuantity} ',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                                const Gap(AppSizes.xs),
                                LinearPercentIndicator(
                                  //lineHeight: AppSizes.xs,
                                  percent:
                                      (groupShoppingController
                                              .groupShoppingGroup
                                              .value
                                              .popular![index]
                                              .currentUserQuantity!
                                              .toDouble() /
                                          groupShoppingController
                                              .groupShoppingGroup
                                              .value
                                              .popular![index]
                                              .totalUserQuantity!
                                              .toDouble()),
                                  padding: EdgeInsets.zero,
                                  backgroundColor: AppColors.lightGrey,
                                  progressColor: AppColors.success,
                                ),
                                const Gap(AppSizes.sm),
                                SizedBox(
                                  width: 205,
                                  child: AppButtons.largeFlatFilledButton(
                                    backgroundColor: AppColors.secondary,
                                    verticallyPadding: AppSizes.sm,
                                    onPressed: () {
                                      if (AppLocalStorage().readData(
                                            LocalStorageKeys.isLoggedIn,
                                          ) ==
                                          true) {
                                        groupShoppingController
                                                    .groupShoppingGroup
                                                    .value
                                                    .popular?[index]
                                                    .isPurchased ==
                                                true
                                            ? AppHelperFunctions.showToast(
                                              "You already a member of this group",
                                            )
                                            : Get.toNamed(
                                              '/group-shopping/${groupShoppingController.groupShoppingGroup.value.popular![index].token}',
                                              parameters: {
                                                'productId':
                                                    "${groupShoppingController.groupShoppingGroup.value.popular![index].product!.id}",
                                                'group_price':
                                                    '${groupShoppingController.groupShoppingGroup.value.popular![index].groupPurchasePrice}',
                                                'shipping_charge':
                                                    '${groupShoppingController.groupShoppingGroup.value.popular![index].groupShippingCharge}',
                                              },
                                            );
                                      } else {
                                        Get.toNamed(
                                          '/login',
                                          arguments: {
                                            "prevRoute": '/group-shopping',
                                          },
                                        );
                                      }
                                    },
                                    buttonText:
                                        groupShoppingController
                                                    .groupShoppingGroup
                                                    .value
                                                    .popular?[index]
                                                    .isPurchased ==
                                                true
                                            ? "JOINED"
                                            : 'JOIN GROUP',
                                  ),
                                ),
                                SizedBox(
                                  width: 205,
                                  child: AppButtons.largeFlatFilledButton(
                                    backgroundColor: AppColors.secondary,
                                    verticallyPadding: AppSizes.sm,
                                    onPressed: () {
                                      final String link =
                                          '${AppApiEndPoints.baseUrl}/group-shopping/${groupShoppingController.groupShoppingGroup.value.popular![index].token}';
                                      Share.share(link);
                                    },
                                    buttonText: 'SHARE',
                                  ),
                                ),
                              ],
                            ),
                          );
                    },
                  ),
                );
          }),
          const Gap(AppSizes.defaultSpace),
        ],
      ),
    );
  }
}
