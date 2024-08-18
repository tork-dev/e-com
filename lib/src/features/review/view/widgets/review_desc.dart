import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/features/review/controller/review_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppReviewDescriptionPart extends StatelessWidget {
  final int index;
  const AppReviewDescriptionPart({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final reviewController = ReviewController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() {
        return Visibility(
                child: ExpandableNotifier(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expandable(
                        collapsed: SizedBox(
                          height: 40,
                          child: Text(
                              reviewController.reviewResponse.value.data![index].comment!),
                        ),
                        expanded: SizedBox(
                          child: Text(
                              reviewController.reviewResponse.value.data![index].comment!),
                        ),

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Builder(
                            builder: (context) {
                              var controller = ExpandableController.of(context);
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, top: 8.0),
                                child: Visibility(
                                  visible: reviewController.reviewResponse.value.data![index].comment!.length > 200 ,
                                  child: GestureDetector(
                                    child: Text(
                                        !controller!.expanded
                                            ? 'view More'
                                            : 'Show Less',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .apply(
                                                color: AppColors.primary,
                                                decoration:
                                                    TextDecoration.underline)),
                                    onTap: () {
                                      controller.toggle();
                                      print(reviewController.reviewResponse.value.data![index].comment!.length.toString());
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(AppSizes.spaceBtwDefaultItems),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
