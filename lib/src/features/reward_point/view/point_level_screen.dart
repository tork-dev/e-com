import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/reward_point/controller/point_reward_Level_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../utils/constants/image_strings.dart';
import 'widgets/kip_card_widget.dart';

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
            children: const [
              // Obx(() {
              //     return AppListViewLayout(
              //         itemCount: !controller.hittingApi.value
              //             ? controller.pointLevel.value.data!.length
              //             : 5,
              //         builderFunction: (context, index) {
              //           return controller.hittingApi.value
              //               ? ShimmerHelper().buildBasicShimmer(height: 100)
              //               : AppCardContainer(
              //                   padding: const EdgeInsets.symmetric(
              //                       horizontal: AppSizes.spaceBtwDefaultItems,
              //                       vertical: AppSizes.md),
              //                   applyRadius: false,
              //                   backgroundColor: AppColors.lightGrey,
              //                   child: ListTile(
              //                     leading: CircleAvatar(
              //                       backgroundColor: AppColors.white,
              //                       child: Image.network(
              //                           controller.pointLevel.value.data![index].icon ?? ''),
              //                     ),
              //                     title: RichText(
              //                         text: TextSpan(
              //                             text: controller
              //                                 .pointLevel.value.data![index].title,
              //                             style: Theme.of(context)
              //                                 .textTheme
              //                                 .titleLarge,
              //                             children: [
              //                           TextSpan(
              //                               text: ' (Level ${index + 1})',
              //                               style: Theme.of(context)
              //                                   .textTheme
              //                                   .labelMedium)
              //                         ])),
              //                     subtitle: Text(
              //                       controller.pointLevel.value.data![index].description ?? 'Minimum ${controller.pointLevel.value.data![index].minRewardPoint} point need to be a ${controller.pointLevel.value.data![index].title} member',
              //                       style: Theme.of(context).textTheme.bodyMedium,
              //                     ),
              //                   ));
              //         });
              //   }
              // )

              KipCardWidget(
                cardColor: Color(0xffF7F7F7),
                messageSideColor: Color(0xffB9BDBD),
                kipIcon: AppImages.silverIcon,
                kipTitle: 'KIP-Silver',
                kipSubtitle:
                    'Become a KIP-Silver member with just one successful order!',
                pointQuantity: '1',
                kipMessage:
                    'Start earning points right away and redeem them on your future purchases',
              ),
              Gap(AppSizes.defaultSpace),
              KipCardWidget(
                cardColor: Color(0xffF7F6ED),
                messageSideColor: Color(0xffE8AB16),
                kipIcon: AppImages.goldIcon,
                kipTitle: 'KIP-Gold',
                kipSubtitle:
                    'Earn 100 points successfully within the last 6 months to reach KIP-Gold status.',
                pointQuantity: '1.5',
                kipMessage:
                    'Exclusive Benefits: Enjoy special discounts on selected products and early access to offers.',
              ),
              Gap(AppSizes.defaultSpace),
              KipCardWidget(
                cardColor: Color(0xffF7F2ED),
                messageSideColor: Color(0xffE57122),
                kipIcon: AppImages.platinumIcon,
                kipTitle: 'KIP-Platinum',
                kipSubtitle:
                    'Achieve KIP-Platinum by earning 300 points successfully in the last 6 months.',
                pointQuantity: '2',
                kipMessage:
                    'Platinum Perks: Unlock exclusive discounts on selected products, special gifts, and first access to promotions and offers.',
              ),
              Gap(AppSizes.spaceBtwSections),
            ],
          ),
        ));
  }
}
