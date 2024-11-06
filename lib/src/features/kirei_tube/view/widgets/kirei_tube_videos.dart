import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_shorts_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../../common/layouts/gridview_layout/gridview_layout.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/kirei_tube_controller.dart';
import 'kirei_tube_list_card.dart';

class KireiTubeVideosTab extends StatelessWidget {
  const KireiTubeVideosTab({super.key});

  @override
  Widget build(BuildContext context) {
    final kireiTubeController = KireiTubeController.instance;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Column(
          children: [
            const Gap(AppSizes.defaultSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  kireiTubeController.tabController.index == 1
                      ? 'Videos'
                      : kireiTubeController.tabController.index == 2
                          ? 'Shorts'
                          : 'Playlist',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                kireiTubeController.tabController.index == 3
                    ? DropdownMenu<String>(
                        hintText: 'Sort by',
                        width: 128,
                        inputDecorationTheme: const InputDecorationTheme(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: 0),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.lightGrey))),
                        onSelected: (String? value) {
                          kireiTubeController.selectedSortKey.value = value!;
                          debugPrint(kireiTubeController.selectedSortKey.value);
                        },
                        dropdownMenuEntries: kireiTubeController.sortKeys
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      )
                    : Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          3,
                          (int index) {
                            return Obx(() {
                              return ChoiceChip(
                                backgroundColor: AppColors.white,
                                shape: const ContinuousRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: AppColors.lightGrey)),
                                elevation: 0,
                                labelPadding: EdgeInsets.zero,
                                showCheckmark: false,
                                labelStyle: TextStyle(
                                    color: kireiTubeController
                                                .selectedFilter.value ==
                                            index
                                        ? AppColors.white
                                        : AppColors.secondary),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.sm),
                                label: Text(
                                    kireiTubeController.filterOption[index]),
                                selected:
                                    kireiTubeController.selectedFilter.value ==
                                        index,
                                onSelected: (bool selected) {
                                  kireiTubeController.selectedFilter.value =
                                      selected ? index : null;
                                },
                              );
                            });
                          },
                        ).toList(),
                      ),
              ],
            ),
            const Gap(AppSizes.md),
            GetBuilder<KireiTubeController>(builder: (controller) {
              return AppGridViewLayout(
                  mobileAspect:
                      kireiTubeController.tabController.index == 2 ? .57 : .94,
                  itemCount: controller.hittingApi.value
                      ? 10
                      : controller.videoList.value.data!.length,
                  builderFunction: (context, index) => controller
                          .hittingApi.value
                      ? ShimmerHelper().buildBasicShimmer(height: 250)
                      : kireiTubeController.tabController.index == 2
                          ? KireiTubeShortsCard(
                              hittingApi: controller.hittingApi.value,
                              shortsBanner: controller
                                      .videoList.value.data?[index].banner ??
                                  '',
                              shortsTitle: controller
                                      .videoList.value.data?[index].title ??
                                  '',
                              shortsViewCount: controller.videoList.value
                                      .data?[index].statistics?.viewCount ??
                                  '0')
                          : KireiTubeListCard(
                    onTapBanner: (){
                      Get.toNamed(
                          '/kirei-tube/${controller.videoList.value
                              .data![index].slug}');
                    },
                              isPlaylist:
                                  kireiTubeController.tabController.index == 3
                                      ? true
                                      : false,
                              kireiTubeBanner: controller
                                  .videoList.value.data?[index].banner,
                              kireiTubeTitle:
                                  controller.videoList.value.data?[index].title,
                              kireiTubeViewsCount: controller.videoList.value
                                  .data?[index].statistics?.viewCount,
                              kireiTubeLikeCount: controller.videoList.value
                                  .data?[index].statistics?.likeCount,
                              kireiTubeCommentCount: controller.videoList.value
                                  .data?[index].statistics?.commentCount,
                              kireiTubePlaylistVideoCount: '6',
                            ));
            }),
          ],
        ),
      ),
    );
  }
}
