import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/features/purchase_history/controller/purchase_history_controller.dart';
import 'package:kirei/src/features/purchase_history/view/widget/purchase_history_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class PurchaseHistory extends StatelessWidget {
  final bool backToHome;

  const PurchaseHistory({super.key, this.backToHome = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PurchaseHistoryController());
    return PopScope(
      canPop: !backToHome,
      onPopInvoked: (pop) {
        if (pop == true) {
          Future.delayed(Duration.zero, () {
            Get.back();
          });
        } else {
          Get.offAll(() => const HelloConvexAppBar(
                pageIndex: 0,
              ));
        }
      },
      child: AppLayoutWithBackButton(
        showBackButton: false,
        customLeadingIcon: Icons.arrow_back,
        leadingIconColor: AppColors.darkGrey,
        showCustomLeading: true,
        leadingOnPress: () => backToHome
            ? Get.offAll(() => const HelloConvexAppBar(
                  pageIndex: 0,
                ))
            : Get.back(),
        padding: AppSizes.sm,
        title: const Text(
          'Purchase History',
          style: TextStyle(color: AppColors.primary),
        ),
        body: Obx(() {
            return AppLayoutWithRefresher(
                onRefresh: controller.onRefresh,
                children: [
                  !controller.hittingApi.value && controller.purchaseHistoryList.value.data!.isEmpty?
                   Center(
                    child: Text(
                      "You haven't any order yet",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ): const AppPurchaseHistoryCard()
                ]);
          }
        ),
      ),
    );
  }
}
