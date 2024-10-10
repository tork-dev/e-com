import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/community/controller/community_comment_controller.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/constants/colors.dart';

class CommunityCommentScreen extends StatelessWidget {
  const CommunityCommentScreen({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommunityCommentController(postId: postId));

    return AppLayoutWithBackButton(
        padding: 0,
        title: Text(
          'Comment Page',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: AppColors.backLayoutAppBarTitle),
        ),
        backgroundColor: AppColors.white,
        bodyBackgroundColor: Colors.grey[100],
        leadingIconColor: AppColors.darkGrey,
        body: SizedBox(
          child: CommentBox(
            userImage: NetworkImage(
                AppLocalStorage().readData(LocalStorageKeys.avatarOriginal)),
            labelText: 'Write a comment...',
            textColor: AppColors.white,
            withBorder: false,
            errorText: 'Comment cannot be blank',
            commentController: controller.commentController,
            backgroundColor: Colors.black,
            formKey: controller.formKey,
            sendWidget:
                const Icon(Icons.send_sharp, size: 30, color: Colors.white),
            sendButtonMethod: () {
              if (controller.formKey.currentState!.validate()) {
                controller.addCommunityComment();
                FocusScope.of(context).unfocus();
              } else {
                AppHelperFunctions.showToast('Please write a comment');
              }
            },
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: !controller.isLoading.value &&
                        controller.communityCommentResponse.value.data!.isEmpty
                    ? const Center(
                        child: Text('No comment here'),
                      )
                    : AppListViewLayout(
                        applyPadding: false,
                        itemCount: controller.isLoading.value
                            ? 10
                            : controller
                                .communityCommentResponse.value.data!.length,
                        builderFunction: (BuildContext context, int index) =>
                            controller.isLoading.value
                                ? ShimmerHelper().buildBasicShimmer(height: 50)
                                : ListTile(
                                    leading: AppBannerImage(
                                      applyImageRadius: true,
                                      imgBoarderRadius: 100,
                                      height: 50,
                                      width: 50,
                                      isNetworkImage: true,
                                      imgUrl:
                                          controller.communityCommentResponse.value.data![index].customerAvatar,
                                    ),
                                    title: Text(controller
                                        .communityCommentResponse
                                        .value
                                        .data![index]
                                        .customerName!),
                                    subtitle: Text(
                                      controller.communityCommentResponse.value
                                          .data![index].comment!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  )),
              );
            }),
          ),
        ));
  }
}
