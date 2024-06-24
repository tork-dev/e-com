import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

class AppQuestionDescriptionPart extends StatelessWidget {
  const AppQuestionDescriptionPart({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsPageController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() {
        return detailsController.productDetails.value.detailedProducts == null
            ? ShimmerHelper().buildBasicShimmer(height: 50)
            : Visibility(
                child: ExpandableNotifier(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expandable(
                        collapsed: SizedBox(
                          height: 40,
                          child: Text(
                              "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley"),
                        ),
                        expanded: SizedBox(
                          child: Text(
                              "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley"),
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
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(AppSizes.spaceBtwItems),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
