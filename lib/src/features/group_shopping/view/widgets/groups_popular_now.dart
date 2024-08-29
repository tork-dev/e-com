import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/features/group_shopping/controller/group_shopping_controller.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

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
              sectionTitle: 'Most popular groups',
              haveTxtButton: false,
            ),
            const Gap(AppSizes.spaceBtwDefaultItems),
            Obx( () {
                return !groupShoppingController.hittingApi.value && groupShoppingController.groupShoppingGroup.value.popular!.isNotEmpty? SizedBox(
                  height: 360,
                  child: AppListViewLayout(
                      itemCount: groupShoppingController.hittingApi.value
                          ? 2
                          : groupShoppingController
                                  .groupShoppingGroup.value.popular?.length ??
                              2,
                      isScrollVertically: false,
                      builderFunction: (context, index) {
                        return groupShoppingController.hittingApi.value
                            ? ShimmerHelper().buildBasicShimmer(width: 220)
                            : AppCardContainer(
                                applyShadow: true,
                                width: 221,
                                applyRadius: false,
                                backgroundColor: AppColors.white,
                                padding: const EdgeInsets.all(AppSizes.sm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppBannerImage(
                                        width: 205,
                                        height: 112,
                                        applyImageRadius: false,
                                        isNetworkImage: true,
                                        fit: BoxFit.cover,
                                        imgUrl: groupShoppingController
                                                .groupShoppingGroup
                                                .value
                                                .popular![index]
                                                .product
                                                ?.thumbnailImage),
                                    const Gap(AppSizes.sm),
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
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: AppColors.darkGrey,
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              const Gap(AppSizes.sm)
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "৳${groupShoppingController.groupShoppingGroup.value.popular![index].product?.salePrice ?? 0}",
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
                                    const Gap(AppSizes.spaceBtwDefaultItems),
                                    Text(
                                      groupShoppingController
                                              .groupShoppingGroup
                                              .value
                                              .popular![index]
                                              .product
                                              ?.name ??
                                          '',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Gap(AppSizes.sm),
                                    Row(
                                      children: [
                                        AppBannerImage(
                                          height: 30,
                                          width: 30,
                                          applyImageRadius: true,
                                          imgUrl: groupShoppingController
                                                  .groupShoppingGroup
                                                  .value
                                                  .popular![index]
                                                  .groupAdmin
                                                  ?.avatar ??
                                              AppImages.avatarIcon,
                                        ),
                                        const Gap(AppSizes.sm),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Created by ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .apply(
                                                      color: AppColors.secondary),
                                              children: [
                                                TextSpan(
                                                    text: groupShoppingController
                                                            .groupShoppingGroup
                                                            .value
                                                            .popular![index]
                                                            .groupAdmin
                                                            ?.name ??
                                                        '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium)
                                              ]),
                                        ),
                                      ],
                                    ),
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
                                          '${groupShoppingController.groupShoppingGroup.value.popular![index].currentUserQuantity} / ${groupShoppingController.groupShoppingGroup.value.popular![index].totalUserQuantity} ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        )
                                      ],
                                    ),
                                    const Gap(AppSizes.xs),
                                    LinearPercentIndicator(
                                      //lineHeight: AppSizes.xs,
                                      percent: .2,
                                      padding: EdgeInsets.zero,
                                      backgroundColor: AppColors.lightGrey,
                                      progressColor: AppColors.success,
                                    ),
                                    const Gap(AppSizes.sm),
                                    SizedBox(
                                      width: 205,
                                      child: AppButtons.largeFlatFilledButton(
                                          onPressed: () {
                                            Get.toNamed(
                                                '/group-shopping/${groupShoppingController.groupShoppingGroup.value.popular![index].token}');
                                          },
                                          buttonText: 'JOIN GROUP',
                                        backgroundColor: AppColors.addToCartButton,
                                        verticallyPadding: AppSizes.sm
                                      ),
                                    ),
                                    SizedBox(
                                      width: 205,
                                      child: AppButtons.largeFlatFilledButton(
                                          onPressed: () {
                                            final String link =
                                                '${AppApiEndPoints.baseUrl}/group-shopping/${groupShoppingController.groupShoppingGroup.value.popular![index].token}';
                                            Share.share(link);
                                          },
                                          buttonText: 'SHARE',
                                          backgroundColor: AppColors.addToCartButton,
                                          verticallyPadding: AppSizes.sm),
                                    ),
                                  ],
                                ));
                      }),
                ) : Center(
                  child: Column(
                    children: [
                      Text('No Group Found', style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),
                );
              }
            ),
            Gap(AppSizes.defaultSpace),
          ],
        )

    );
  }
}
