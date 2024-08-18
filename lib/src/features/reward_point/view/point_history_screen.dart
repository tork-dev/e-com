import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/reward_point/controller/point_history_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class RewardPointHistoryScreen extends StatelessWidget {
  const RewardPointHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RewardPointHistoryController());
    return AppLayoutWithBackButton(
        padding: AppSizes.md,
        title: const Text(
          'Point History',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        body: AppLayoutWithRefresher(
            onRefresh: controller.onRefresh,
            children: [
              AppListViewLayout(
                  itemCount: 10,
                  builderFunction: (context, index){
                    return AppCardContainer(
                      applyRadius: false,
                      padding: const EdgeInsets.all(AppSizes.md),
                        backgroundColor: AppColors.lightGrey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Order placed on 22 Dec 2023', style: Theme.of(context).textTheme.bodyLarge,),
                                Text('+100', style: Theme.of(context).textTheme.bodyMedium!.apply(color: AppColors.success),),
                              ],
                            ),
                            Text('Order placed on 22 Dec 2023', style: Theme.of(context).textTheme.labelMedium,),
                          ],
                        ));
                  })
            ]));
  }
}
