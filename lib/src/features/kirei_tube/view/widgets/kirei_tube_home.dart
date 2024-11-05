import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kirei/src/common/layouts/gridview_layout/gridview_layout.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/search_bar/search_widget.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../controller/kirei_tube_controller.dart';
import 'kirei_tube_list_card.dart';

class KireiTubeHome extends StatelessWidget {
  const KireiTubeHome({super.key});

  @override
  Widget build(BuildContext context) {
    final kireiController = KireiTubeController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(AppSizes.spaceBtwSections),

            const AppSectionTitleText(
              sectionTitle: 'Videos',
              haveTxtButton: false,
            ),
            GetBuilder<KireiTubeController>(
              builder: (controller) {
                return AppGridViewLayout(
                    mobileAspect: .94,
                    itemCount: 4,
                    builderFunction: (context, index) => controller.hittingApi.value
                        ? ShimmerHelper().buildBasicShimmer(height: 250)
                        : KireiTubeListCard(index: index));
              }
            ),

            const Gap(AppSizes.defaultSpace),
            SizedBox(
              height: 32,
              width: 94,
              child: AppButtons.largeFlatFilledButton(
                  onPressed: () {
                    kireiController.switchTab(1);
                  },
                  backgroundColor: AppColors.secondary,
                  verticallyPadding: 0,
                  buttonText: 'View more'),
            )
          ],
        ),
      ),
    );
  }
}
