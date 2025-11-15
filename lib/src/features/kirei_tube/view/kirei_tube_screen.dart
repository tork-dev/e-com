import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_controller.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_home.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_videos.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class KireiTubeScreen extends StatelessWidget {
  const KireiTubeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KireiTubeController());

    return AppLayoutWithBackButton(

        title: const Text(
          'Kirei Tube',
          style: TextStyle(color: AppColors.secondary),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      padding: 0,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: GetBuilder<KireiTubeController>(builder: (controller) {
              return controller.hittingApi.value
                  ? ShimmerHelper().buildBasicShimmer(height: 215)
                  : Stack(
                      children: [
                        AppBannerImage(
                            height: 215,
                            width: AppHelperFunctions.screenWidth(),
                            isNetworkImage: true,
                            applyImageRadius: false,
                            imgUrl: controller.kireiTubeHomeResponse.value
                                    .setting?.banner ??
                                ''),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl, vertical: 48),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.kireiTubeHomeResponse.value.setting?.subtitle ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .apply(color: AppColors.primary),
                                ),
                                const Gap(AppSizes.sm),
                                Text(
                                  controller.kireiTubeHomeResponse.value.setting
                                          ?.tittle ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!,
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(AppSizes.sm),
                                Text(
                                  AppHelperFunctions.stripHtmlTags(controller
                                          .kireiTubeHomeResponse
                                          .value
                                          .setting
                                          ?.description ??
                                      ''),
                                  style: Theme.of(context).textTheme.bodySmall!,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            }),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                  TabBar(
                    controller: controller.tabController,
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    labelStyle: Theme.of(context).textTheme.titleLarge,
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.spaceBtwDefaultItems),
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    physics: const NeverScrollableScrollPhysics(),
                    onTap: (value) {
                      controller.searchController.clear();
                    },
                    tabs: const [
                      Tab(text: 'Home'),
                      Tab(text: 'Videos'),
                      Tab(text: 'Shorts'),
                      Tab(text: 'Playlists'),
                    ],
                  ),
                  controller.searchController, (value) {
                if (controller.tabController.index == 3) {
                  controller.getKireitubePlaylist();
                } else if (controller.tabController.index == 0) {
                  controller.getKireiTubeHomeData();
                } else {
                  controller.getKireitubeVideos();
                }
              }, controller.tabController.index != 0)),
        ],
        body: TabBarView(
          controller: controller.tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            KireiTubeHome(),
            KireiTubeVideosTab(),
            KireiTubeVideosTab(),
            KireiTubeVideosTab(),
          ],
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final TextEditingController controller;
  final dynamic onChanged;
  final bool needSearch;

  _TabBarDelegate(
      this.tabBar, this.controller, this.onChanged, this.needSearch);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      color: Colors.white,
      child: Column(
        children: [
          tabBar,
          Visibility(
            visible: true,
            child: Column(
              children: [
                const Gap(AppSizes.md),
                SizedBox(
                  height: 48,
                  child: SearchBar(
                    controller: controller,
                    onChanged: onChanged,
                    elevation: const WidgetStatePropertyAll(0),
                    backgroundColor:
                        const WidgetStatePropertyAll(AppColors.white),
                    shape: const WidgetStatePropertyAll(BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppSizes.cardRadiusXs)),
                      side: BorderSide(
                          color: AppColors.lightGrey,
                          width: 1), // Border color and width
                    )),
                    hintText: 'Search',
                    hintStyle: WidgetStatePropertyAll(Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: AppColors.lightGrey)),
                    trailing: const [
                      Icon(
                        Icons.search_sharp,
                        color: AppColors.lightGrey,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 129;

  @override
  double get minExtent => 129;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return true; // Rebuild when the tab bar changes
  }
}
