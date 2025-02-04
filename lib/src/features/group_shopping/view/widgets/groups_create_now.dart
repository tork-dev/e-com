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
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../../../utils/constants/app_api_end_points.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class GroupShoppingCreateNowGroups extends StatelessWidget {
  const GroupShoppingCreateNowGroups({super.key});

  @override
  Widget build(BuildContext context) {
    final groupShoppingController = GroupShoppingController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionTitleText(
            sectionTitle: 'Just created group',
            haveTxtButton: false,
          ),
          const Gap(AppSizes.spaceBtwDefaultItems),
          Obx(() {
            return !groupShoppingController.hittingGroupApi.value &&
                groupShoppingController
                    .groupShoppingGroup.value.justCreated!.isEmpty
                ? Center(
              child: Column(
                children: [
                  Text(
                    'No Group Found',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                  ),
                ],
              ),
            )
                : SizedBox(
              height: 375,
              child: AppListViewLayout(
                  itemCount: groupShoppingController.hittingGroupApi.value
                      ? 5
                      : groupShoppingController
                      .groupShoppingGroup.value.justCreated!.length,
                  isScrollVertically: false,
                  builderFunction: (context, index) {
                    return groupShoppingController.hittingGroupApi.value
                        ? ShimmerHelper()
                        .buildBasicShimmer(width: 200, height: 200)
                        : AppCardContainer(
                        applyShadow: true,
                        width: 221,
                        applyRadius: false,
                        backgroundColor: AppColors.white,
                        padding: const EdgeInsets.all(AppSizes.sm),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                AppBannerImage(
                                  height: 120,
                                  width: 215,
                                  fit: BoxFit.contain,
                                  imgUrl: groupShoppingController
                                      .groupShoppingGroup
                                      .value
                                      .justCreated![index]
                                      .product
                                      ?.thumbnailImage ??
                                      '',
                                  isNetworkImage: true,
                                  applyImageRadius: false,
                                ),
                                AppCardContainer(
                                    width: 140,
                                    applyRadius: false,
                                    backgroundColor:
                                    const Color(0xffE4F7E8),
                                    // padding: const EdgeInsets.all(
                                    //     AppSizes.xs),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Duration: ",
                                          style: TextStyle(
                                              color:
                                              AppColors.primary,
                                              fontSize: 10,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        SlideCountdown(
                                          duration: Duration(
                                              days: groupShoppingController
                                                  .groupShoppingGroup
                                                  .value
                                                  .justCreated![index]
                                                  .expiredAt!
                                                  .day,
                                              hours: groupShoppingController
                                                  .groupShoppingGroup
                                                  .value
                                                  .justCreated![index]
                                                  .expiredAt!
                                                  .hour,
                                              minutes:
                                              groupShoppingController
                                                  .groupShoppingGroup
                                                  .value
                                                  .justCreated![
                                              index]
                                                  .expiredAt!
                                                  .minute,
                                              seconds:
                                              groupShoppingController
                                                  .groupShoppingGroup
                                                  .value
                                                  .justCreated![
                                              index]
                                                  .expiredAt!
                                                  .second),
                                          decoration:
                                          const BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          durationTitle:
                                          const DurationTitle(
                                              days: "d : ",
                                              hours: "h : ",
                                              minutes: "m : ",
                                              seconds: "s"),
                                          separatorPadding:
                                          EdgeInsets.zero,
                                          separatorType:
                                          SeparatorType.title,
                                          style: const TextStyle(
                                              color:
                                              AppColors.primary,
                                              fontSize: 10),
                                          separatorStyle:
                                          const TextStyle(
                                              color: AppColors
                                                  .primary),
                                          padding: EdgeInsets.zero,
                                          shouldShowMinutes:
                                              (duration) =>
                                          duration.inDays ==
                                              0,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            const Gap(AppSizes.spaceBtwDefaultItems),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: true,
                                  child: Row(
                                    children: [
                                      Text(
                                        "৳${groupShoppingController
                                            .groupShoppingGroup.value
                                            .justCreated![index].product
                                            ?.price ?? 0}",
                                        textAlign: TextAlign.left,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            decoration: TextDecoration
                                                .lineThrough,
                                            color: AppColors.darkGrey,
                                            fontSize: 9,
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                      const Gap(AppSizes.sm)
                                    ],
                                  ),
                                ),
                                Text(
                                  "৳${groupShoppingController.groupShoppingGroup
                                      .value.justCreated![index].groupPurchasePrice ?? 0}",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                              child: Text(
                                groupShoppingController
                                    .groupShoppingGroup
                                    .value
                                    .justCreated![index]
                                    .product
                                    ?.name ??
                                    '',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge,
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
                                        .justCreated![index]
                                        .groupAdmin
                                        ?.avatar !=
                                        null,
                                    imgUrl: groupShoppingController
                                        .groupShoppingGroup
                                        .value
                                        .justCreated![index]
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
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .labelMedium!
                                            .apply(
                                            color: AppColors
                                                .secondary),
                                        children: [
                                          TextSpan(
                                            text: groupShoppingController
                                                .groupShoppingGroup
                                                .value
                                                .justCreated![
                                            index]
                                                .groupAdmin
                                                ?.name ??
                                                '',
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium,
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
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelMedium,
                                ),
                                Text(
                                  '${groupShoppingController.groupShoppingGroup
                                      .value.justCreated![index]
                                      .currentUserQuantity} / ${groupShoppingController
                                      .groupShoppingGroup.value
                                      .justCreated![index].totalUserQuantity} ',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelMedium,
                                )
                              ],
                            ),
                            const Gap(AppSizes.xs),
                            LinearPercentIndicator(
                              percent: (groupShoppingController.groupShoppingGroup
                                  .value.justCreated![index]
                                  .currentUserQuantity!.toDouble() / groupShoppingController
                                  .groupShoppingGroup.value
                                  .justCreated![index].totalUserQuantity!.toDouble()),
                              padding: EdgeInsets.zero,
                              backgroundColor: AppColors.lightGrey,
                              progressColor: AppColors.success,
                            ),
                            const Gap(AppSizes.sm),
                            SizedBox(
                              width: 205,
                              child: AppButtons.largeFlatFilledButton(
                                  backgroundColor:
                                  AppColors.secondary,
                                  verticallyPadding: AppSizes.sm,
                                  onPressed: () {
                                    groupShoppingController.groupShoppingGroup
                                        .value.justCreated?[index].isPurchased == true
                                        ? AppHelperFunctions.showToast(
                                        "You already a member of this group")
                                        :
                                    Get.toNamed(
                                        '/group-shopping/${groupShoppingController
                                            .groupShoppingGroup.value
                                            .justCreated![index].token}',
                                        parameters: {
                                          'productId':
                                          "${groupShoppingController
                                              .groupShoppingGroup.value
                                              .justCreated![index].product!.id}",
                                          'group_price' : '${groupShoppingController
                                              .groupShoppingGroup.value
                                              .justCreated![index].groupPurchasePrice}',
                                          'shipping_charge' : '${groupShoppingController
                                              .groupShoppingGroup.value
                                              .justCreated![index].groupShippingCharge}',
                                        });
                                  },
                                  buttonText: groupShoppingController
                                      .groupShoppingGroup.value
                                      .justCreated?[index].isPurchased == true
                                      ? "JOINED" : 'JOIN GROUP'),
                            ),
                            SizedBox(
                              width: 205,
                              child: AppButtons.largeFlatFilledButton(
                                  backgroundColor:
                                  AppColors.secondary,
                                  verticallyPadding: AppSizes.sm,
                                  onPressed: () {
                                    final String link =
                                        '${AppApiEndPoints
                                        .baseUrl}/group-shopping/${groupShoppingController
                                        .groupShoppingGroup.value
                                        .justCreated![index].token}';
                                    Share.share(link);
                                  },
                                  buttonText: 'SHARE'),
                            )
                          ],
                        ));
                  }),
            );
          }),
          const Gap(AppSizes.defaultSpace),
        ],
      ),
    );
  }
}
