import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/purchase_history/controller/purchase_history_controller.dart';
import 'package:kirei/src/features/purchase_history/view/widget/purchase_history_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PurchaseHistoryController());
    return  AppLayoutWithBackButton(
      padding: AppSizes.sm,
      title: const Text('Purchase History', style: TextStyle(color: AppColors.primary),),
      body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children: const [
            AppPurchaseHistoryCard()
          ]), );
  }
}

