import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/community/controller/community_controller.dart';

import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class CommunityPostContainer extends StatelessWidget {
  const CommunityPostContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final communityController = CommunityController.instance;
    return Obx(() {
      return AppListViewLayout(
        itemCount: communityController.isLoading.value
            ? 5
            : communityController.communityResponse.value.data!.length,
        builderFunction: (context, index) =>
        communityController.isLoading.value
                ? ShimmerHelper().buildBasicShimmer(height: 150)
                : AppCardContainer(
                    backgroundColor: AppColors.white,
                    padding: const EdgeInsets.all(AppSizes.md),
                    applyShadow: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             const AppBannerImage(
                                applyPadding: true,
                                hasBorder: true,
                                borderColor: Colors.transparent,
                                backgroundColor: AppColors.grey,
                                borderWidth: 1,
                                applyImageRadius: true,
                                boarderRadius: 100,
                                height: 50,
                                width: 50,
                                imgUrl: AppImages.profileIcon),
                            const Gap(AppSizes.sm),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  communityController.communityResponse.value.data![index].customerName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .apply(color: AppColors.darkGrey),
                                ),
                                Text(
                                  communityController.communityResponse.value.data![index].date!,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            )
                          ],
                        ),
                        const Gap(AppSizes.sm),
                         Text(communityController.communityResponse.value.data![index].description!),
                        const Gap(AppSizes.sm),
                         Center(
                          child: AppBannerImage(
                              height: 150,
                              applyImageRadius: false,
                              isNetworkImage: true,
                              imgUrl: communityController.communityResponse.value.data![index].banner ?? ''),
                        ),
                        const Gap(AppSizes.spaceBtwItems),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${communityController.communityResponse.value.data![index].commentsCount} Comment"),
                            SizedBox(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: AppColors.darkGrey,
                                  ),
                                  const Gap(AppSizes.sm),
                                  Text('love',
                                      style:
                                          Theme.of(context).textTheme.bodySmall)
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )),
      );
    });
  }
}
