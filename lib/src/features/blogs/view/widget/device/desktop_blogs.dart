// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import '../../../../../../common/layouts/layout_with_refresher/layout_with_refresher.dart';
// import '../../../../../../common/layouts/listview_layout/listview_layout.dart';
// import '../../../../../../common/styles/skeleton_style.dart';
// import '../../../../../../common/widgets/containers/banner_image.dart';
// import '../../../../../../common/widgets/containers/card_container.dart';
// import '../../../../../../utils/constants/colors.dart';
// import '../../../../../../utils/constants/sizes.dart';
// import '../../../../../../utils/helpers/helper_functions.dart';
// import '../../../../blogs_details/view/blogs_details.dart';
// import '../../../controller/blogs_controller.dart';
// import '../../../model/blogs_dummy_data.dart';
// import '../blog_filter.dart';
//
// class DesktopBlogs extends StatelessWidget {
//   const DesktopBlogs({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final blogsController = BlogsController.instance;
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Column(
//         children: [
//           AppHelperFunctions.appDivider(),
//           const Gap(AppSizes.msGap),
//
//           SizedBox(
//             height: AppHelperFunctions.screenHeight(),
//             child: AppLayoutWithRefresher(
//                 onRefresh: blogsController.onRefresh,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
//                     child: BlogFilterPart(),
//                   ),
//                   const Gap(AppSizes.msGap),
//                   Obx(() =>
//                   blogsController.isApiHitting.value == false && blogsController.blogsResponseData.value.data!.isEmpty
//                       ? const Center(
//                     child: Text("No Blogs Available Right Now"),
//                   )
//                       :
//                       AppListViewLayout(
//                       itemCount: blogsController.isApiHitting.value == true ? 5 : blogsController.blogsResponseData.value.data!.length,
//                       builderFunction: (context, index) {
//                         return blogsController.isApiHitting.value == true ?
//                         ShimmerHelper().buildBasicShimmer(
//                             height: 390,
//                             width: AppHelperFunctions.screenWidth()
//                         ) :
//                         AppCardContainer(
//                           height: 390,
//                           backgroundColor: AppColors.white,
//                           applyShadow: true,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: AppSizes.mobilePadding,
//                               vertical: AppSizes.mobilePadding
//                           ),
//                           margin: const EdgeInsets.symmetric(horizontal: AppSizes.mobilePadding),
//                           onTap: (){
//                             Get.to(() => BlogsDetails(
//                               slug: blogsController.blogsResponseData.value.data![index].slug!,
//                             ));
//                           },
//                           child: Column(
//                             children: [
//                               AppBannerImage(
//                                   height: 192,
//                                   applyImageRadius: true,
//                                   boarderRadius: 12,
//                                   isNetworkImage: true,
//                                   imgUrl: "${blogsController.blogsResponseData.value.data![index].banner}"
//                               ),
//
//                               const Gap(AppSizes.mmGap),
//
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "${blogsController.blogsResponseData.value.data![index].blogCategoryTitle}",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headlineSmall!
//                                         .apply(
//                                       color: AppColors.buttonTextColor,
//                                     ),
//                                   ),
//                                   Text(
//                                     BlogsDummyData.blogList[index].postTime
//                                         .toString(),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleMedium!
//                                         .apply(
//                                       color: AppColors.textTertiary,
//                                     ),
//                                   )
//                                 ],
//                               ),
//
//                               const Gap(AppSizes.slGap),
//
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "${blogsController.blogsResponseData.value.data![index].title}",
//                                     style:
//                                     Theme.of(context).textTheme.headlineSmall,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//
//                                   const Gap(AppSizes.smGap),
//
//                                   Html(data: "${blogsController.blogsResponseData.value.data![index].body}",
//                                     style: {
//                                       "p": Style(
//                                         maxLines: 2,
//                                         textOverflow: TextOverflow.ellipsis,
//                                         textAlign: TextAlign.left,
//                                         margin: Margins.zero,
//                                       ),
//                                       "body": Style(
//                                         margin: Margins.zero,
//                                         padding: HtmlPaddings.zero,
//                                       ),
//                                     },
//                                   ),
//                                 ],
//                               )
//
//                             ],
//                           ),
//                         );
//                       }
//                       )
//                   ),
//                   const Gap(200),
//                 ]
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
