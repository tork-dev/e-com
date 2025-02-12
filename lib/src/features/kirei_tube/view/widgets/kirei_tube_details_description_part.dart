import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_details_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:share_plus/share_plus.dart';

class KireiTubeDetailsDescription extends StatelessWidget {
  const KireiTubeDetailsDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final kireiTubeDetailsController = KireiTubeDetailsController.instance;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kireiTubeDetailsController.hittingApi.value
              ? ShimmerHelper().buildBasicShimmer(height: 30)
              : Text(
                  kireiTubeDetailsController
                      .kireiTubeDetailsResponse.value.data!.title!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
          kireiTubeDetailsController.hittingApi.value
              ? ShimmerHelper().buildBasicShimmer(height: 50)
              : HtmlWidget(
                  kireiTubeDetailsController.kireiTubeDetailsResponse.value.data!.shortDescription ?? '',
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
                ),
          const Gap(AppSizes.spaceBtwItems),
          InkWell(
              onTap: () async {
                final String link = kireiTubeDetailsController.kireiTubeDetailsResponse.value.data!.video!;
                await Share.share(link);
              },
              child: const Icon(Icons.share)),
          const Gap(AppSizes.spaceBtwItems),
        ],
      );
    });
  }
}
