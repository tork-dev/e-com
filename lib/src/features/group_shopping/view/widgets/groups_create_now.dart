import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../common/widgets/texts/section_title_text.dart';
import '../../../../utils/constants/app_api_end_points.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/group_shopping_controller.dart';

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
            // Check if hitting API or no groups found
            if (groupShoppingController.hittingApi.value) {
              return SizedBox(
                height: 410,
                child: AppListViewLayout(
                  itemCount: 5,
                  isScrollVertically: false,
                  builderFunction: (context, index) => ShimmerHelper()
                      .buildBasicShimmer(width: 200),
                ),
              );
            }

            final justCreatedGroups = groupShoppingController
                .groupShoppingGroup.value.justCreated;

            // Check if there are just created groups
            if (justCreatedGroups != null && justCreatedGroups.isNotEmpty) {
              return SizedBox(
                height: 410,
                child: AppListViewLayout(
                  itemCount: justCreatedGroups.length,
                  isScrollVertically: false,
                  builderFunction: (context, index) {
                    final group = justCreatedGroups[index];

                    return AppCardContainer(
                      applyShadow: true,
                      width: 221,
                      applyRadius: false,
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
                                imgUrl: group.product?.thumbnailImage ?? '',
                                isNetworkImage: true,
                                applyImageRadius: false,
                              ),
                              AppCardContainer(
                                applyRadius: false,
                                backgroundColor: const Color(0xffE4F7E8),
                                padding: const EdgeInsets.all(AppSizes.xs),
                                child: Obx(() {
                                  groupShoppingController.endTime.value =
                                  group.expiredAt!;
                                  return RichText(
                                    text: TextSpan(
                                      text: 'Duration: ',
                                      style: const TextStyle(
                                        fontSize: 8,
                                        color: AppColors.secondary,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: groupShoppingController
                                              .remainingTime.value,
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          const Gap(AppSizes.sm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (group.product?.price != null) ...[
                                Text(
                                  "৳${group.product?.price}",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColors.darkGrey,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(AppSizes.sm),
                              ],
                              Text(
                                "৳${group.product?.salePrice ?? 0}",
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
                              group.product?.name ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
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
                                  isNetworkImage: group.groupAdmin?.avatar != null,
                                  imgUrl: group.groupAdmin?.avatar ?? AppImages.avatarIcon,
                                ),
                                const Gap(AppSizes.sm),
                                Expanded(
                                  child: RichText(
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Created by ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .apply(color: AppColors.secondary),
                                      children: [
                                        TextSpan(
                                          text: group.groupAdmin?.name ?? '',
                                          style: Theme.of(context).textTheme.bodyMedium,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Expired at: ',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                DateFormat('dd MMMM', 'fr_FR')
                                    .format(group.expiredAt!),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const Gap(AppSizes.spaceBtwDefaultItems),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Joined Members',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                '${group.currentUserQuantity} / ${group.totalUserQuantity}',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const Gap(AppSizes.xs),
                          LinearPercentIndicator(
                            percent: (group.currentUserQuantity! / group.totalUserQuantity!),
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
                                Get.toNamed(
                                  '/group-shopping/${group.token}',
                                  parameters: {
                                    'productId': "${group.product!.id}",
                                  },
                                );
                              },
                              buttonText: 'JOIN GROUP',
                            ),
                          ),
                          SizedBox(
                            width: 205,
                            child: AppButtons.largeFlatFilledButton(
                              backgroundColor: AppColors.secondary,
                              verticallyPadding: AppSizes.sm,
                              onPressed: () {
                                final String link =
                                    '${AppApiEndPoints.baseUrl}/group-shopping/${group.token}';
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
            } else {
              return Center(
                child: Column(
                  children: [
                    Text(
                      'No Group Found',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            }
          }),
          const Gap(AppSizes.defaultSpace),
        ],
      ),
    );
  }
}
