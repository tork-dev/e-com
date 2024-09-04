import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import '../../../../utils/constants/app_api_end_points.dart';
import '../../../../utils/constants/colors.dart';

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
            sectionTitle: 'Just created groups',
            haveTxtButton: false,
          ),
          const Gap(AppSizes.spaceBtwDefaultItems),
          Obx(() {
            return !groupShoppingController.hittingApi.value &&
                    groupShoppingController
                        .groupShoppingGroup.value.justCreated!.isNotEmpty
                ? SizedBox(
                    height: 400,
                    child: AppListViewLayout(
                        itemCount: groupShoppingController.hittingApi.value
                            ? 5
                            : groupShoppingController
                                .groupShoppingGroup.value.justCreated!.length,
                        isScrollVertically: false,
                        builderFunction: (context, index) {
                          return groupShoppingController.hittingApi.value
                              ? ShimmerHelper().buildBasicShimmer(width: 200)
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
                                      AppBannerImage(
                                          width: 205,
                                          height: 115,
                                          fit: BoxFit.cover,
                                          applyImageRadius: false,
                                          isNetworkImage: true,
                                          imgUrl: groupShoppingController
                                                  .groupShoppingGroup
                                                  .value
                                                  .justCreated![index]
                                                  .product
                                                  ?.thumbnailImage ??
                                              ''),
                                      const Gap(AppSizes.sm),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: true,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "৳${groupShoppingController.groupShoppingGroup.value.justCreated![index].product?.price ?? 0}",
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
                                            "৳${groupShoppingController.groupShoppingGroup.value.justCreated![index].product?.salePrice ?? 0}",
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
                                          style: Theme.of(context)
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
                                                  style: Theme.of(context)
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
                                                      style: Theme.of(context)
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
                                      const Gap(AppSizes.sm),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Expired at: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          Text(
                                            DateFormat('dd MMMM', 'fr_FR')
                                                .format(groupShoppingController
                                                    .groupShoppingGroup
                                                    .value
                                                    .justCreated![index]
                                                    .expiredAt!),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                        ],
                                      ),
                                      const Gap(AppSizes.spaceBtwDefaultItems),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Joined Members',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          Text(
                                            '${groupShoppingController.groupShoppingGroup.value.justCreated![index].currentUserQuantity} / ${groupShoppingController.groupShoppingGroup.value.justCreated![index].totalUserQuantity} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          )
                                        ],
                                      ),
                                      const Gap(AppSizes.xs),
                                      LinearPercentIndicator(
                                        percent: (groupShoppingController
                                                .groupShoppingGroup
                                                .value
                                                .justCreated![index]
                                                .currentUserQuantity! /
                                            groupShoppingController
                                                .groupShoppingGroup
                                                .value
                                                .justCreated![index]
                                                .totalUserQuantity!),
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
                                              Get.toNamed(
                                                  '/group-shopping/${groupShoppingController.groupShoppingGroup.value.justCreated![index].token}',
                                                  parameters: {
                                                    'productId':
                                                        "${groupShoppingController.groupShoppingGroup.value.justCreated![index].product!.id}"
                                                  });
                                            },
                                            buttonText: 'JOIN GROUP'),
                                      ),
                                      SizedBox(
                                        width: 205,
                                        child: AppButtons.largeFlatFilledButton(
                                            backgroundColor:
                                                AppColors.secondary,
                                            verticallyPadding: AppSizes.sm,
                                            onPressed: () {
                                              final String link =
                                                  '${AppApiEndPoints.baseUrl}/group-shopping/${groupShoppingController.groupShoppingGroup.value.justCreated![index].token}';
                                              Share.share(link);
                                            },
                                            buttonText: 'SHARE'),
                                      )
                                    ],
                                  ));
                        }),
                  )
                : Center(
                    child: Column(
                      children: [
                        Text(
                          'No Group Found',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
          }),
          const Gap(AppSizes.defaultSpace),
        ],
      ),
    );
  }
}
