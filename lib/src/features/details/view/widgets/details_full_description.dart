import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppDetailsFullDescription extends StatelessWidget {
  const AppDetailsFullDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsPageController.instance;
    return Obx(() {
      return detailsController.productDetails.value.detailedProducts == null
          ?  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: ShimmerHelper().buildBasicShimmer(height: 50))
          : ExpansionTile(
              title: Text('Description'.toUpperCase()),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: HtmlWidget(detailsController
                      .productDetails.value.detailedProducts!.description
                      .toString()),
                ),
                const Gap(AppSizes.spaceBtwDefaultItems)
              ],
            );
    });
  }
}
