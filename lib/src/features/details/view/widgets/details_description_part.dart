import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppDetailsDescriptionPart extends StatelessWidget {
  const AppDetailsDescriptionPart({super.key});

  @override
  Widget build(BuildContext context) {
    DetailsPageController detailsController = DetailsPageController.instance;
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
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                HtmlWidget(detailsController.productDetails.value
                                        .detailedProducts!.shortDescription ??
                                    ''),
                              ],
                            )),
                        expanded: SizedBox(
                            child: HtmlWidget(detailsController.productDetails
                                    .value.detailedProducts!.shortDescription ??
                                '')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Builder(
                            builder: (context) {
                              var controller = ExpandableController.of(context);
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 10.0, top: 8.0),
                                child: GestureDetector(
                                  child: Text(
                                      !controller!.expanded
                                          ? 'view More'
                                          : 'Show Less',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .apply(color: AppColors.darkGrey)),
                                  onTap: () {
                                    controller.toggle();
                                  },
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
