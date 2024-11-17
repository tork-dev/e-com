import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/features/kirei_tube/view/kirei_tube_playlist_view.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_shorts_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../../common/layouts/gridview_layout/gridview_layout.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/kirei_tube_controller.dart';
import 'kirei_tube_list_card.dart';

class KireiTubeVideosTab extends StatefulWidget {
  const KireiTubeVideosTab({super.key});

  @override
  State<KireiTubeVideosTab> createState() => _KireiTubeVideosTabState();
}

class _KireiTubeVideosTabState extends State<KireiTubeVideosTab> {
  final kireiTubeController = KireiTubeController.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kireiTubeController.tabController.index != 3) {
      if (kireiTubeController.tabController.index == 1) {
        kireiTubeController.selectedOrientation.value = 'landscape';
      } else if (kireiTubeController.tabController.index == 2) {
        kireiTubeController.selectedOrientation.value = "portrait";
      }
      kireiTubeController.getKireitubeVideos();
    } else {
      kireiTubeController.getKireitubePlaylist();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: AppSizes.sm, vertical: 0),
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
                                  if (kireiTubeController
                                          .selectedFilter.value ==
                                      null) {
                                    kireiTubeController.orderBy.value = '';
                                    kireiTubeController.isPopular.value = 0;
                                  } else if (kireiTubeController
                                              .selectedFilter.value !=
                                          null &&
                                      kireiTubeController
                                              .selectedFilter.value !=
                                          1) {
                                    kireiTubeController.isPopular.value = 0;
                                    kireiTubeController.orderBy.value =
                                        kireiTubeController.filterOption[
                                                kireiTubeController
                                                    .selectedFilter.value!]
                                            .toLowerCase();
                                  } else if (kireiTubeController
                                          .selectedFilter.value !=
                                      null) {
                                    kireiTubeController.orderBy.value = '';
                                    kireiTubeController.isPopular.value = 1;
                                  }

                                  kireiTubeController.getKireitubeVideos();
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
                      : kireiTubeController.tabController.index == 3
                          ? controller.videoPlaylist.value.data!.length
                          : controller.videosList.value.data!.length,
                  builderFunction: (context, index) => controller
                          .hittingApi.value
                      ? ShimmerHelper().buildBasicShimmer(height: 250)
                      : kireiTubeController.tabController.index == 2
                          ? KireiTubeShortsCard(
                              onShortsPress: () {
                                Get.toNamed(
                                    "/kirei-shorts/${controller.videosList.value.data![index].slug}");
                              },
                              hittingApi: controller.hittingApi.value,
                              shortsBanner: controller
                                      .videosList.value.data?[index].banner ??
                                  '',
                              shortsTitle: controller
                                      .videosList.value.data?[index].title ??
                                  '',
                            )
                          : KireiTubeListCard(
                              onTapBanner: () {
                                Get.toNamed(
                                    '/kirei-tube/${controller.videosList.value.data![index].slug}');
                              },
                              isPlaylist:
                                  kireiTubeController.tabController.index == 3
                                      ? true
                                      : false,
                              onTapViewPlaylist: () {
                                kireiTubeController.getKireitubePlaylistDetails(
                                    controller
                                        .videoPlaylist.value.data![index].id
                                        .toString());
                                Get.to(() => const KireiTubePlaylistScreen());
                              },
                              kireiTubeBanner:
                                  kireiTubeController.tabController.index == 3
                                      ? controller.videoPlaylist.value
                                          .data![index].banner
                                      : controller
                                          .videosList.value.data?[index].banner,
                              kireiTubeTitle:
                                  kireiTubeController.tabController.index == 3
                                      ? controller.videoPlaylist.value
                                          .data![index].title
                                      : controller
                                          .videosList.value.data?[index].title,
                              kireiTubePlaylistVideoCount: '6',
                            ));
            }),
          ],
        ),
      ),
    );
  }
}
