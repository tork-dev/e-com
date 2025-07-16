// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:material_symbols_icons/symbols.dart';
// import 'package:share_plus/share_plus.dart';
// import '../../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
// import '../../../../common/layouts/layout_with_refresher/layout_with_refresher.dart';
// import '../../../../common/layouts/listview_layout/listview_layout.dart';
// import '../../../../common/styles/skeleton_style.dart';
// import '../../../../common/widgets/containers/banner_image.dart';
// import '../../../../l10n/app_localizations.dart';
// import '../../../../utils/constants/app_api_end_points.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../../../utils/helpers/helper_functions.dart';
// import '../../../../utils/local_storage/local_storage_keys.dart';
// import '../../../../utils/local_storage/storage_utility.dart';
// import '../../../../utils/responsive/responsive.dart';
// import '../../settings/controller/theme_controller.dart';
// import '../controller/blogs_details_controller.dart';
// import 'widget/comment_section.dart';
// import 'widget/post_comment.dart';
//
// class BlogsDetails extends StatelessWidget {
//   const BlogsDetails({super.key, required this.slug});
//
//   final String slug;
//
//   @override
//   Widget build(BuildContext context) {
//     final blogDetailsController = Get.put(BlogsDetailsController(slug: slug));
//     final themeController = ThemeController.instance;
//
//     return AppLayoutWithBackButton(
//       defaultPadding: false,
//       customPadding: EdgeInsets.zero,
//       title: Text(
//         AppLocalizations.of(context)!.blogsDetails,
//         style: Theme.of(context).textTheme.headlineMedium,
//       ),
//       body: Stack(
//         children: [
//           AppLayoutWithRefresher(
//             onRefresh: blogDetailsController.onRefresh,
//             children: [
//               AppHelperFunctions.appDivider(),
//               Obx(() {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: ResponsiveWidget.isDesktop(context)
//                         ? AppSizes.desktopPadding
//                         : ResponsiveWidget.isTablet(context)
//                             ? AppSizes.tabletPadding
//                             : AppSizes.mobilePadding,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Gap(AppSizes.mlGap),
//                       blogDetailsController.isApiHitting.value
//                           ? ShimmerHelper().buildBasicShimmer(height: 20)
//                           : Text(
//                               blogDetailsController.blogsDetailsResponseData
//                                   .value.data!.createdAt!,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleMedium!
//                                   .apply(
//                                     color: AppColors.textTerms,
//                                   ),
//                             ),
//                       const Gap(AppSizes.slGap),
//                       blogDetailsController
//                                   .blogsDetailsResponseData.value.data ==
//                               null
//                           ? ShimmerHelper().buildBasicShimmer(
//                               height: 30,
//                               width: AppHelperFunctions.screenWidth(),
//                             )
//                           : Text(
//                               "${blogDetailsController.blogsDetailsResponseData.value.data!.title}",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineSmall!
//                                   .copyWith(
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                             ),
//                       const Gap(AppSizes.msGap),
//                       blogDetailsController
//                                   .blogsDetailsResponseData.value.data ==
//                               null
//                           ? ShimmerHelper().buildBasicShimmer(
//                               height: 160,
//                               width: AppHelperFunctions.screenWidth(),
//                             )
//                           : Stack(
//                               children: [
//                                 AppBannerImage(
//                                   height: 250,
//                                   fit: BoxFit.cover,
//                                   isNetworkImage: true,
//                                   width: AppHelperFunctions.screenWidth(),
//                                   imgUrl:
//                                       "${blogDetailsController.blogsDetailsResponseData.value.data!.banner}",
//                                 ),
//                                 Positioned(
//                                   right: 10,
//                                   top: 10,
//                                   child: InkWell(
//                                     onTap: () async {
//                                       final result = await Share.share(
//                                           '${AppLocalStorage().readData(LocalStorageKeys.appUrl)}/course/${blogDetailsController.slug}');
//
//                                       if (result.status ==
//                                           ShareResultStatus.success) {
//                                         http.post(
//                                             Uri.parse(
//                                                 AppApiEndPoints.rewardShareApi),
//                                             headers: {
//                                               "Accept": "*/*",
//                                               "Content-Type":
//                                                   "application/json",
//                                               'Authorization':
//                                                   "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}",
//                                             },
//                                             body: jsonEncode({
//                                               "model": "blog",
//                                               "model_row_id":
//                                                   blogDetailsController
//                                                       .blogsDetailsResponseData
//                                                       .value
//                                                       .data!
//                                                       .id,
//                                               "created_from": "app"
//                                             }));
//                                       }
//                                     },
//                                     child: Card(
//                                       shape: const CircleBorder(),
//                                       color: AppColors.white.withOpacity(.9),
//                                       elevation: 20,
//                                       child: const Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: Icon(
//                                           Symbols.share,
//                                           color: AppColors.secondaryColor,
//                                           size: AppSizes.iconMd,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                       const Gap(AppSizes.msGap),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               AppBannerImage(
//                                 height: ResponsiveWidget.isDesktop(context)
//                                     ? 44
//                                     : ResponsiveWidget.isTablet(context)
//                                         ? 40
//                                         : 36,
//                                 width: ResponsiveWidget.isDesktop(context)
//                                     ? 44
//                                     : ResponsiveWidget.isTablet(context)
//                                         ? 40
//                                         : 36,
//                                 applyImageRadius: true,
//                                 boarderRadius: 100,
//                                 fit: BoxFit.cover,
//                                 backgroundColor: AppColors.light,
//                                 imgUrl: "assets/images/user/user.png",
//                               ),
//                               const Gap(AppSizes.slGap),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Admin',
//                                     style:
//                                         Theme.of(context).textTheme.titleMedium,
//                                   ),
//                                   Text(
//                                     'Uylab',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .labelMedium!
//                                         .apply(
//                                           color:
//                                               !themeController.isDarkMode.value
//                                                   ? AppColors.textTertiary
//                                                   : AppColors.lightGrey,
//                                         ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                           blogDetailsController
//                                       .blogsDetailsResponseData.value.data ==
//                                   null
//                               ? ShimmerHelper().buildBasicShimmer(
//                                   height: 10,
//                                   width: 100,
//                                 )
//                               : Visibility(
//                                   visible: blogDetailsController
//                                           .blogsDetailsResponseData
//                                           .value
//                                           .data!
//                                           .readingTime !=
//                                       null,
//                                   child: Text(
//                                     "${blogDetailsController.blogsDetailsResponseData.value.data!.readingTime} mins to Read",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .labelMedium!
//                                         .apply(
//                                           color: AppColors.textTertiary,
//                                         ),
//                                   ),
//                                 ),
//                         ],
//                       ),
//                       const Gap(AppSizes.msGap),
//                       blogDetailsController
//                                   .blogsDetailsResponseData.value.data ==
//                               null
//                           ? ShimmerHelper().buildBasicShimmer(
//                               height: 300,
//                               width: AppHelperFunctions.screenWidth(),
//                             )
//                           : Text(
//                               AppHelperFunctions().stripHtmlTags(
//                                   blogDetailsController.blogsDetailsResponseData
//                                           .value.data?.body ??
//                                       ''),
//                               style: Theme.of(context).textTheme.bodyLarge,
//                             ),
//                       const Gap(AppSizes.mlGap),
//                       blogDetailsController.isApiHitting.value
//                           ? ShimmerHelper().buildBasicShimmer(height: 20)
//                           : Text(
//                               '${blogDetailsController.blogsDetailsResponseData.value.data!.comments?.length ?? 0} Comment',
//                               style: Theme.of(context).textTheme.titleLarge,
//                             ),
//                       const Gap(AppSizes.smGap),
//                       AppListViewLayout(
//                           itemCount: blogDetailsController.isApiHitting.value
//                               ? 5
//                               : blogDetailsController.blogsDetailsResponseData
//                                   .value.data!.comments!.length,
//                           builderFunction: (context, index) =>
//                               blogDetailsController.isApiHitting.value
//                                   ? ShimmerHelper()
//                                       .buildBasicShimmer(height: 50)
//                                   : BlogCommentSection(
//                                       comment: blogDetailsController
//                                           .blogsDetailsResponseData
//                                           .value
//                                           .data!
//                                           .comments![index])),
//                       const Gap(AppSizes.appBarHeight),
//                       const Gap(AppSizes.appBarHeight)
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: PostComment(
//               onTextFieldTap: () =>
//                   blogDetailsController.commentController.clear(),
//               commentController: blogDetailsController.commentController,
//               textFileFocusNode: blogDetailsController.focusOnTextField.value,
//               onSendButtonPress: () {
//                 // Logic for posting the comment
//                 if (blogDetailsController.commentController.text.isNotEmpty) {
//                   blogDetailsController.postComments();
//                   // communityController.commentController.clear();
//                   FocusScope.of(context).unfocus();
//                   // Add the post comment logic here
//                 } else {
//                   AppHelperFunctions.showToast(
//                       message: 'Please write something');
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
