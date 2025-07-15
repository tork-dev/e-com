// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import '../../../../../../common/layouts/layout_with_refresher/layout_with_refresher.dart';
// import '../../../../../../common/layouts/listview_layout/listview_layout.dart';
// import '../../../../../../common/styles/skeleton_style.dart';
// import '../../../../../../common/widgets/containers/banner_image.dart';
// import '../../../../../../common/widgets/containers/card_container.dart';
// import '../../../../../../common/widgets/containers/no_data_container.dart';
// import '../../../../../../utils/constants/colors.dart';
// import '../../../../../../utils/constants/sizes.dart';
// import '../../../../../../utils/helpers/helper_functions.dart';
// import '../../../../blogs_details/view/blogs_details.dart';
// import '../../../../settings/controller/theme_controller.dart';
// import '../../../controller/blogs_controller.dart';
// import '../blog_filter.dart';
//
// class MobileBlogs extends StatelessWidget {
//   const MobileBlogs({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final blogsController = BlogsController.instance;
//     final themeController = ThemeController.instance;
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Column(
//         children: [
//           AppHelperFunctions.appDivider(),
//           SizedBox(
//             height: AppHelperFunctions.screenHeight(),
//             child: AppLayoutWithRefresher(
//               onRefresh: blogsController.onRefresh,
//               scrollController: blogsController.scrollController,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
//                   child: BlogFilterPart(),
//                 ),
//                 const Gap(AppSizes.msGap),
//                 Obx(
//                   () => blogsController.isApiHitting.value == false &&
//                           blogsController.blogList.isEmpty
//                       ? const Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: AppSizes.md),
//                           child: AppNoDataContainer(
//                             noDataText: "No Blogs Available Right Now",
//                           ),
//                         )
//                       : AppListViewLayout(
//                           isScrollVertically: true,
//                           itemCount: blogsController.isApiHitting.value
//                               ? 3 // Show fewer shimmer items during loading
//                               : blogsController.blogList.length,
//                           builderFunction: (context, index) {
//                             if (blogsController.isApiHitting.value) {
//                               // Show shimmer while loading
//                               return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: AppSizes.md),
//                                   child: ShimmerHelper().buildBasicShimmer(
//                                       height: 360,
//                                       width: AppHelperFunctions.screenWidth()));
//                             }
//
//                             // Render actual blog data
//                             final blogItem =
//                                 blogsController.blogList[index];
//
//                             return AppCardContainer(
//                               backgroundColor: !themeController.isDarkMode.value? AppColors.white : AppColors.containerColorDark,
//                               applyShadow: !themeController.isDarkMode.value,
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: AppSizes.mobilePadding,
//                                   vertical: AppSizes.mobilePadding),
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: AppSizes.mobilePadding),
//                               onTap: () {
//                                 Get.to(() => BlogsDetails(
//                                       slug: blogItem.slug!,
//                                     ));
//                               },
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   AppBannerImage(
//                                     height: 192,
//                                     applyImageRadius: true,
//                                     boarderRadius: 12,
//                                     fit: BoxFit.cover,
//                                     isNetworkImage: true,
//                                     width: AppHelperFunctions.screenWidth(),
//                                     imgUrl: blogItem.banner!,
//                                   ),
//                                   const Gap(AppSizes.mmGap),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       AppCardContainer(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 6),
//                                         backgroundColor: AppColors.primaryColor,
//                                         child: Text(
//                                           blogItem.blogCategoryTitle!,
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .titleSmall!
//                                               .apply(
//                                                 color: AppColors.white,
//                                               ),
//                                         ),
//                                       ),
//                                       Text(
//                                         blogsController
//                                             .blogList[index].createdAt
//                                             .toString(),
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleMedium!
//                                             .apply(
//                                               color: !themeController.isDarkMode.value ? AppColors.textTertiary : AppColors.lightGrey,
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                   const Gap(AppSizes.slGap),
//                                   AppCardContainer(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           blogItem.title!,
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .headlineSmall,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                         const Gap(AppSizes.smGap),
//                                         Text(
//                                           AppHelperFunctions().stripHtmlTags(
//                                               blogsController
//                                                       .blogList[index]
//                                                       .body ??
//                                                   ''),
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//                 const Gap(200),
//               ],
//             ),
//           ),
//           const Gap(100),
//         ],
//       ),
//     );
//   }
// }
