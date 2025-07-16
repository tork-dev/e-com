import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../common/layouts/layout_with_refresher/layout_with_refresher.dart';
import '../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controller/blogs_controller.dart';
import 'blog_filter.dart';

class MobileBlogs extends StatelessWidget {
  const MobileBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    final blogsController = BlogsController.instance;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Gap(AppSizes.defaultSpace),
          SizedBox(
            height: AppHelperFunctions.screenHeight(),
            child: AppLayoutWithRefresher(
              onRefresh: blogsController.onRefresh,
              scrollController: blogsController.scrollController,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
                  child: BlogFilterPart(),
                ),
                const Gap(AppSizes.spaceBtwItems),
                Obx(
                  () =>
                      blogsController.isApiHitting.value == false &&
                              blogsController.blogList.isEmpty
                          ? const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.md,
                            ),
                            // child: AppNoDataContainer(
                            //   noDataText: "No Blogs Available Right Now",
                            // ),
                            child: Text("No Blogs Found"),
                          )
                          : AppListViewLayout(
                            isScrollVertically: true,
                            itemCount:
                                blogsController.isApiHitting.value
                                    ? 3 // Show fewer shimmer items during loading
                                    : blogsController.blogList.length,
                            builderFunction: (context, index) {
                              if (blogsController.isApiHitting.value) {
                                // Show shimmer while loading
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.md,
                                  ),
                                  child: ShimmerHelper().buildBasicShimmer(
                                    height: 360,
                                    width: AppHelperFunctions.screenWidth(),
                                  ),
                                );
                              }

                              // Render actual blog data
                              final blogItem = blogsController.blogList[index];

                              return AppCardContainer(
                                backgroundColor: AppColors.white,
                                applyShadow: true,
                                padding: const EdgeInsets.all(AppSizes.md),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.md,
                                ),
                                onTap: () {
                                  // Get.to(() => BlogsDetails(
                                  //       slug: blogItem.slug!,
                                  //     ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppBannerImage(
                                      height: 192,
                                      applyImageRadius: true,
                                      boarderRadius: 12,
                                      fit: BoxFit.cover,
                                      isNetworkImage: true,
                                      width: AppHelperFunctions.screenWidth(),
                                      imgUrl:
                                          (blogItem.picture?.isNotEmpty ??
                                                  false)
                                              ? blogItem.picture![0].url
                                              : "https://v2.kireibd.com/_next/image?url=%2Fimages%2Fbeauty%2Fbeauty-home.png&w=828&q=75",
                                    ),
                                    const Gap(AppSizes.md),
                                    AppCardContainer(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      backgroundColor: AppColors.whitePink,
                                      borderRadius: AppSizes.cardRadiusXs,
                                      child: Text(
                                        blogItem.blogCategories![0].name!,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall!,
                                      ),
                                    ),

                                    const Gap(AppSizes.md),
                                    AppCardContainer(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            blogItem.title!,
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.headlineSmall,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Gap(AppSizes.md),
                                          Text(
                                            AppHelperFunctions().stripHtmlTags(
                                              blogsController
                                                      .blogList[index]
                                                      .content ??
                                                  '',
                                            ),
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                ),
                const Gap(200),
              ],
            ),
          ),
          const Gap(100),
        ],
      ),
    );
  }
}
