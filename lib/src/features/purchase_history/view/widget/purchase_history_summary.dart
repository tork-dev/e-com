import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/features/purchase_history/controller/purchase_history_details_controller.dart';
import 'package:torganic/src/features/purchase_history/view/widget/summary_text_widget.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

class AppPurchaseHistoryDetailsSummary extends StatelessWidget {
  const AppPurchaseHistoryDetailsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = PurchaseHistoryDetailsController.instance;
    return Align(
      alignment: Alignment.centerRight,
      child: Obx((){
          return detailsController.purchaseHistoryDetails.value.data == null?
              ShimmerHelper().buildBasicShimmer(height: 150):
          Column(
            children: [
              SummaryTextWidget(
                  title: 'SUBTOTAL',
                  amount: detailsController.purchaseHistoryDetails.value.data![0].subtotal!),
              const Gap(AppSizes.xs),
              SummaryTextWidget(
                  title: 'TAX',
                  amount: detailsController.purchaseHistoryDetails.value.data![0].tax!),
              const Gap(AppSizes.xs),
              SummaryTextWidget(
                  title: 'SHIPPING COST',
                  amount: detailsController.purchaseHistoryDetails.value.data![0].shippingCost!),
              const Gap(AppSizes.xs),
              SummaryTextWidget(
                  title: 'DISCOUNT',
                  amount: detailsController.purchaseHistoryDetails.value.data![0].couponDiscount!),
              const Gap(AppSizes.xs),
               SizedBox(
                width: 270,
                child: AppDividersStyle.fullFlatAppDivider,
              ),
              const Gap(AppSizes.xs),
              SummaryTextWidget(
                  title: 'GRAND TOTAL',
                  amount: detailsController.purchaseHistoryDetails.value.data![0].grandTotal!),
              const Gap(AppSizes.xl),
            ],);
        }
      ),
    );
  }
}

