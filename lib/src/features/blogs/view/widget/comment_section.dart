import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/features/blogs/controller/blogs_controller.dart';

import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../model/blog_details_model.dart';


class BlogCommentSection extends StatelessWidget {
  const BlogCommentSection({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final blogDetailsController = BlogsController.instance;
    return Padding(
    padding: const EdgeInsets.only(top: AppSizes.sm),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCardContainer(
          padding: const EdgeInsets.all(AppSizes.sm),
          hasBorder: true,
          borderWidth: 1,
          borderColor: AppColors.accent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/user/user.png'),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.name ?? "Guest",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(AppSizes.xs),
                    Text(comment.message ?? ''),
                    const Gap(AppSizes.xs),
                    Text(
                      comment.email ?? '',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    // Display a "Reply" button
                    TextButton(
                      onPressed: () {
                        // blogDetailsController.parentId.value = comment.id;
                        // blogDetailsController.focusOnTextField.value.requestFocus();
                      },
                      child: const Text('Reply'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (comment.replies!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: comment.replies?.length,
              itemBuilder: (context, index) {
                return BlogCommentSection(comment: comment.replies![index]);
              },
            ),
          ),
        ],
      ],
    ),
    );
  }
}

