import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/purchase_history/controller/purchase_history_controller.dart';
import 'package:kirei/src/features/purchase_history/view/widget/paschase_history_details_item.dart';
import 'package:kirei/src/features/purchase_history/view/widget/purchase_history_summary.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../controller/purchase_history_details_controller.dart';
import 'widget/order_shipping_details_card.dart';


class PurchaseHistoryDetails extends StatelessWidget {
  const PurchaseHistoryDetails({super.key});
  

  @override
  Widget build(BuildContext context) {
    String orderId = Get.parameters['id'] ?? '';
    final controller = Get.put(PurchaseHistoryDetailsController());
    controller.onRefresh(int.parse(orderId));
    return  AppLayoutWithBackButton(
      title: const Text('Order Details', style: TextStyle(color: AppColors.secondary),),
        centerTitle: true,
        padding: AppSizes.defaultSpace,
        body: ListView(
            children: [
              const AppOrderShippingDetailsCard(),
              const Gap(AppSizes.spaceBtwSections),
              Center(child: Text('Order Products', style: Theme.of(context).textTheme.titleLarge,)),
              const Gap(AppSizes.spaceBtwDefaultItems),
              const AppPurchaseHistoryDetailsItem(),
              const Gap(AppSizes.spaceBtwSections),
              const AppPurchaseHistoryDetailsSummary()
            ]));
  }
}

