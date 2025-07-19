import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/blogs/controller/blogs_controller.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:share_plus/share_plus.dart';
import '../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../common/layouts/layout_with_refresher/layout_with_refresher.dart';
import '../../../common/styles/skeleton_style.dart';
import '../../../common/widgets/containers/banner_image.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import 'widget/post_comment.dart';

class BlogsDetails extends StatelessWidget {
  const BlogsDetails({super.key});


  @override
  Widget build(BuildContext context) {
    final blogDetailsController = BlogsController.instance;

    return AppLayoutWithBackButton(
      padding: 0,
      title: Text(
        "Blog",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      body: Stack(
        children: [
          AppLayoutWithRefresher(
            onRefresh: blogDetailsController.onRefresh,
            children: [
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.md
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(AppSizes.md),
                      blogDetailsController
                                  .isApiHitting.value
                          ? ShimmerHelper().buildBasicShimmer(
                              height: 160,
                              width: AppHelperFunctions.screenWidth(),
                            )
                          : Stack(
                              children: [
                                AppBannerImage(
                                  height: 250,
                                  fit: BoxFit.cover,
                                  isNetworkImage: true,
                                  width: AppHelperFunctions.screenWidth(),
                                  applyImageRadius: true,
                                  boarderRadius: AppSizes.cardRadiusSm,
                                  imgBoarderRadius: AppSizes.cardRadiusSm,
                                  imgUrl:
                                      "${blogDetailsController.blogsDetailsResponseData.value.banner}",
                                  errorImage: AppImages.beautyTipsOne,
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: InkWell(
                                    onTap: () async {
                                      final result = await Share.share(
                                          '${AppLocalStorage().readData(LocalStorageKeys.appUrl)}/blog/${blogDetailsController.blogsDetailsResponseData.value.slug}');
                                    },
                                    child: Card(
                                      shape: const CircleBorder(),
                                      color: AppColors.white.withOpacity(.9),
                                      elevation: 20,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.share,
                                          color: AppColors.secondary,
                                          size: AppSizes.iconMd,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      const Gap(AppSizes.defaultSpace),
                      blogDetailsController
                          .isApiHitting.value
                          ? ShimmerHelper().buildBasicShimmer(
                        height: 30,
                        width: AppHelperFunctions.screenWidth(),
                      )
                          : Text(
                        "${blogDetailsController.blogsDetailsResponseData.value.title}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const Gap(AppSizes.defaultSpace),
                      blogDetailsController
                                  .isApiHitting.value
                          ? ShimmerHelper().buildBasicShimmer(
                              height: 300,
                              width: AppHelperFunctions.screenWidth(),
                            )
                          // : Text(
                          //     AppHelperFunctions().stripHtmlTags(
                          //         blogDetailsController.blogsDetailsResponseData
                          //                 .value.description ??
                          //             ''),
                          //     style: Theme.of(context).textTheme.bodyLarge,
                          //   ),
                      : HtmlWidget(
                                blogDetailsController.blogsDetailsResponseData
                                        .value.description!
                      ),
                      const Gap(AppSizes.md),
                      // blogDetailsController.isApiHitting.value
                      //     ? ShimmerHelper().buildBasicShimmer(height: 20)
                      //     : Text(
                      //         '${blogDetailsController.blogsDetailsResponseData.value.blogComments!.length ?? 0} Comment',
                      //         style: Theme.of(context).textTheme .titleLarge,
                      //       ),
                      const Gap(AppSizes.sm),
                      // AppListViewLayout(
                      //     itemCount: blogDetailsController.isApiHitting.value
                      //         ? 5
                      //         : blogDetailsController.blogsDetailsResponseData
                      //             .value.blogComments!.length,
                      //     builderFunction: (context, index) =>
                      //         blogDetailsController.isApiHitting.value
                      //             ? ShimmerHelper()
                      //                 .buildBasicShimmer(height: 50)
                      //             : BlogCommentSection(
                      //                 comment: blogDetailsController
                      //                     .blogsDetailsResponseData
                      //                     .value
                      //                     .blogComments![index])),
                      const Gap(AppSizes.appBarHeight),
                      const Gap(AppSizes.appBarHeight)
                    ],
                  ),
                );
              }),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PostComment(
              onTextFieldTap: () {},
              //     blogDetailsController.commentController.clear(),
              // commentController: blogDetailsController.commentController,
              // textFileFocusNode: blogDetailsController.focusOnTextField.value,
              onSendButtonPress: () {
                // Logic for posting the comment
                // if (blogDetailsController.commentController.text.isNotEmpty) {
                //   blogDetailsController.postComments();
                //   // communityController.commentController.clear();
                //   FocusScope.of(context).unfocus();
                  // Add the post comment logic here
                // } else {
                //   AppHelperFunctions.showToast(
                //       message: 'Please write something');
                // }
              }, textFileFocusNode:   FocusNode(), commentController: blogDetailsController.commentController,
            ),
          ),
        ],
      ),
    );
  }
}
