import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:kirei/src/common/layouts/gridview_layout/gridview_layout.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../controller/kirei_tube_controller.dart';
import '../kirei_tube_playlist_view.dart';
import 'kirei_tube_list_card.dart';
import 'kirei_tube_shorts_card.dart';

class KireiTubeHome extends StatelessWidget {
  const KireiTubeHome({super.key});

  @override
  Widget build(BuildContext context) {
    final kireiController = KireiTubeController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
      ),
      child: GetBuilder<KireiTubeController>(builder: (controller) {
        return controller.hittingApi.value
            ? AppListViewLayout(
                itemCount: 5,
                builderFunction: (context, index) =>
                    ShimmerHelper().buildBasicShimmer(height: 250))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: !controller.hittingApi.value &&
                          kireiController.kireiTubeHomeResponse.value.videos!
                              .data!.isNotEmpty,
                      child: Column(
                        children: [
                          const Gap(AppSizes.spaceBtwSections),
                          const AppSectionTitleText(
                            sectionTitle: 'Videos',
                            haveTxtButton: false,
                          ),
                          AppGridViewLayout(
                              mobileAspect: .94,
                              itemCount: controller.kireiTubeHomeResponse.value
                                      .videos?.data?.length ??
                                  4,
                              builderFunction: (context, index) =>
                                  KireiTubeListCard(
                                    isPlaylist: false,
                                    onTapBanner: () {
                                      Get.toNamed(
                                          '/kirei-tube/${controller.kireiTubeHomeResponse.value.videos?.data![index].slug}');
                                    },
                                    kireiTubeBanner: controller
                                        .kireiTubeHomeResponse
                                        .value
                                        .videos
                                        ?.data?[index]
                                        .banner,
                                    kireiTubeTitle: controller
                                        .kireiTubeHomeResponse
                                        .value
                                        .videos
                                        ?.data?[index]
                                        .title,
                                  )),
                          const Gap(AppSizes.md),
                          AppButtons.customFlatFilledButton(
                              onPressed: () {
                                kireiController.switchTab(1);
                              },
                              buttonWidth: 100,
                              backgroundColor: AppColors.secondary,
                              verticallyPadding: AppSizes.sm,
                              horizontalPadding: AppSizes.md,
                              buttonText: 'View more'),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !controller.hittingApi.value &&
                          kireiController.kireiTubeHomeResponse.value.shorts!
                              .data!.isNotEmpty,
                      child: Column(
                        children: [
                          const Gap(AppSizes.spaceBtwSections),
                          AppCardContainer(
                              width: AppHelperFunctions.screenWidth(),
                              applyRadius: false,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.md,
                                  vertical: AppSizes.defaultSpace),
                              backgroundColor: AppColors.headerBackground,
                              child: Column(
                                children: [
                                  const AppSectionTitleText(
                                    sectionTitle: 'Shorts',
                                    haveTxtButton: false,
                                  ),
                                  const Gap(AppSizes.spaceBtwItems),
                                  SizedBox(
                                    height: 305,
                                    child: GetBuilder<KireiTubeController>(
                                        builder: (controller) {
                                      return AppListViewLayout(
                                          itemCount: controller
                                                  .kireiTubeHomeResponse
                                                  .value
                                                  .shorts
                                                  ?.data
                                                  ?.length ??
                                              4,
                                          isScrollVertically: false,
                                          builderFunction: (context, index) =>
                                              KireiTubeShortsCard(
                                                onShortsPress: () {
                                                  print(
                                                      '${controller.kireiTubeHomeResponse.value.shorts?.data![index].slug}');
                                                  Get.toNamed(
                                                      '/kirei-shorts/${controller.kireiTubeHomeResponse.value.shorts?.data![index].slug}');
                                                },
                                                hittingApi:
                                                    controller.hittingApi.value,
                                                shortsBanner: controller
                                                        .kireiTubeHomeResponse
                                                        .value
                                                        .shorts
                                                        ?.data?[index]
                                                        .banner ??
                                                    '',
                                                shortsTitle: controller
                                                        .kireiTubeHomeResponse
                                                        .value
                                                        .shorts
                                                        ?.data?[index]
                                                        .title ??
                                                    '',
                                              ));
                                    }),
                                  ),
                                  const Gap(AppSizes.md),
                                  AppButtons.customFlatFilledButton(
                                      onPressed: () {
                                        kireiController.switchTab(2);
                                      },
                                      buttonWidth: 100,
                                      backgroundColor: AppColors.secondary,
                                      verticallyPadding: AppSizes.sm,
                                      horizontalPadding: AppSizes.md,
                                      buttonText: 'View more'),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !controller.hittingApi.value &&
                          kireiController.kireiTubeHomeResponse.value.playlists!.isNotEmpty,
                      child: Column(
                        children: [
                          const Gap(AppSizes.spaceBtwSections),
                          const AppSectionTitleText(
                            sectionTitle: 'Playlists',
                            haveTxtButton: false,
                          ),
                          GetBuilder<KireiTubeController>(
                              builder: (controller) {
                            return AppGridViewLayout(
                                mobileAspect: .94,
                                itemCount: controller.kireiTubeHomeResponse
                                        .value.playlists?.length ??
                                    4,
                                builderFunction: (context, index) =>
                                    KireiTubeListCard(
                                      onTapViewPlaylist: () {
                                        kireiController
                                            .getKireitubePlaylistDetails(
                                                controller.videoPlaylist.value
                                                    .data![index].id
                                                    .toString());
                                        Get.to(() =>
                                            const KireiTubePlaylistScreen());
                                      },
                                      isPlaylist: true,
                                      kireiTubeBanner: controller
                                          .kireiTubeHomeResponse
                                          .value
                                          .playlists?[index]
                                          .banner,
                                      kireiTubeTitle: controller
                                          .kireiTubeHomeResponse
                                          .value
                                          .playlists?[index]
                                          .title,
                                      kireiTubePlaylistVideoCount: '6',
                                    ));
                          }),
                          const Gap(AppSizes.md),
                          AppButtons.customFlatFilledButton(
                              onPressed: () {
                                kireiController.switchTab(3);
                              },
                              buttonWidth: 100,
                              backgroundColor: AppColors.secondary,
                              verticallyPadding: AppSizes.sm,
                              horizontalPadding: AppSizes.md,
                              buttonText: 'View more'),
                        ],
                      ),
                    ),
                    const Gap(AppSizes.defaultSpace)
                  ],
                ),
              );
      }),
    );
  }
}
