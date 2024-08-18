import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/reward_point/controller/point_reward_Level_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class RewardPointLevelScreen extends StatelessWidget {
  const RewardPointLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RewardPointLevelController());
    return AppLayoutWithBackButton(
        padding: AppSizes.md,
        title: const Text(
          'Levels',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        body: Padding(
          padding: const EdgeInsets.only(top: AppSizes.md),
          child: AppLayoutWithRefresher(
            onRefresh: controller.onRefresh,
            children: [
              AppListViewLayout(
                  itemCount: 3,
                  builderFunction: (context, index) {
                    return AppCardContainer(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.spaceBtwDefaultItems,
                            vertical: AppSizes.md),
                        applyRadius: false,
                        backgroundColor: AppColors.lightGrey,
                        child: ListTile(
                          leading:  Image.asset('assets/images/icons/silver_icon.png'),
                          title: RichText(
                              text: TextSpan(
                                  text: 'Silver ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge,
                                  children: [
                                    TextSpan(
                                        text: ' (Level 1)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium)
                                  ])),
                          subtitle: Text(
                            'It is a long established fact that a reader will be distracted by the readable',
                            style:
                            Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                    );
                  })
            ],
          ),
        ));
  }
}
