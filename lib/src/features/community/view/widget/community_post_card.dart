import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/community/controller/community_controller.dart';
import 'package:kirei/src/features/community/view/community_comment_screen.dart';

import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import 'community_like_button.dart';

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
        builderFunction: (context, index) => communityController.isLoading.value
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
                            SizedBox(
                              width: 250,
                              child: Text(
                                communityController.communityResponse.value
                                    .data![index].customerName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .apply(color: AppColors.darkGrey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              communityController
                                  .communityResponse.value.data![index].date!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Gap(AppSizes.sm),
                    Text(communityController
                            .communityResponse.value.data![index].description ??
                        ''),
                    const Gap(AppSizes.sm),
                    Visibility(
                       visible:communityController.communityResponse.value.data?[index].banner != null,
                      child: Center(
                        child: AppBannerImage(
                            height: 150,
                            applyImageRadius: false,
                            isNetworkImage: true,
                            imgUrl: communityController.communityResponse.value
                                    .data![index].banner ??
                                ''),
                      ),
                    ),
                    const Gap(AppSizes.spaceBtwDefaultItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => Get.to(() => CommunityCommentScreen(
                                postId: communityController
                                    .communityResponse.value.data![index].id!)),
                            child: Text(
                                "${communityController.communityResponse.value.data![index].commentsCount} Comment")),
                        SizedBox(
                            child: CommunityLikeButton(
                          cardIndex: index,
                        ))
                      ],
                    )
                  ],
                )),
      );
    });
  }
}
