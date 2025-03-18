import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_controller.dart';
import 'package:kirei/src/features/kirei_tube/view/kirei_tube_shorts_screen.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'widgets/video_horizontal_card.dart';

class KireiTubePlaylistScreen extends StatelessWidget {
  const KireiTubePlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayoutWithBackButton(
        title: const Text('Playlist'),
        body: SingleChildScrollView(
          child:
              GetBuilder<KireiTubeController>(builder: (kireiTubeController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kireiTubeController.hittingApi.value
                    ? ShimmerHelper().buildBasicShimmer(
                        height: 215, width: AppHelperFunctions.screenWidth())
                    : AppBannerImage(
                        height: 215,
                        width: AppHelperFunctions.screenWidth(),
                        applyImageRadius: false,
                        isNetworkImage: true,
                        fit: BoxFit.cover,
                        imgUrl: kireiTubeController
                            .playlistDetails.value.data?[0].banner),
                const Gap(AppSizes.spaceBtwDefaultItems),
                kireiTubeController.hittingApi.value
                    ? ShimmerHelper().buildBasicShimmer(height: 30)
                    : Text(
                        '${kireiTubeController.playlistDetails.value.data?[0].title}',
                        style: Theme.of(context).textTheme.headlineMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                const Gap(AppSizes.sm),
                Row(
                  children: [
                    const AppBannerImage(
                      height: AppSizes.iconLg,
                      width: AppSizes.iconLg,
                      imgBoarderRadius: 100,
                      boarderRadius: 100,
                      fit: BoxFit.contain,
                      backgroundColor: AppColors.lightGrey,
                      imgUrl: AppImages.lightAppLogo,
                    ),
                    const Gap(AppSizes.spaceBtwDefaultItems),
                    Text(
                      'by KireiBD',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
                const Gap(AppSizes.spaceBtwItems),
                kireiTubeController.hittingApi.value
                    ? ShimmerHelper().buildBasicShimmer(height: 40, width: 150)
                    : AppCardContainer(
                        applyRadius: false,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.md, vertical: 6),
                        backgroundColor: AppColors.addToCartButton,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Playlist',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: AppColors.white),
                            ),
                            const Gap(AppSizes.spaceBtwDefaultItems),
                            Text(
                                '${kireiTubeController.playlistDetails.value.data?[0].videos?.length} Video',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: AppColors.white)),
                          ],
                        )),
                const Gap(AppSizes.spaceBtwSections),
                AppListViewLayout(
                    itemCount: kireiTubeController.hittingApi.value
                        ? 5
                        : kireiTubeController
                            .playlistDetails.value.data![0].videos!.length,
                    builderFunction: (context, index) => kireiTubeController
                            .hittingApi.value
                        ? ShimmerHelper().buildBasicShimmer(height: 150)
                        : VideoHorizontalCard(
                            onTap: () {
                              Get.toNamed('/kirei-tube/${kireiTubeController.playlistDetails.value.data![0].videos![index].slug}');
                                Get.to(
                                    () => const KireiTubeShortsDetailsScreen(),
                                    arguments: {
                                      "id": kireiTubeController.playlistDetails
                                          .value.data![0].videos![index].slug,
                                      "orientation": kireiTubeController.playlistDetails
                                          .value.data![0].videos![index].orientation
                                    });

                            },
                            imgUrl: kireiTubeController.playlistDetails.value
                                .data![0].videos![index].banner,
                            title: kireiTubeController.playlistDetails.value
                                .data![0].videos![index].title,
                            createdAt:
                                AppHelperFunctions.formatTimestampWithAgo(
                                    kireiTubeController.playlistDetails.value
                                        .data![0].videos![index].createdAt),
                          ))
              ],
            );
          }),
        ));
  }
}
