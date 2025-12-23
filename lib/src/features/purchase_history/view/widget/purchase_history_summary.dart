import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/purchase_history/controller/purchase_history_details_controller.dart';
import 'package:kirei/src/features/purchase_history/view/widget/summary_text_widget.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppPurchaseHistoryDetailsSummary extends StatelessWidget {
  const AppPurchaseHistoryDetailsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = PurchaseHistoryDetailsController.instance;
    return Align(
      alignment: Alignment.centerRight,
      child: Obx((){
          return detailsController.orderDetailsData.value.products == null?
              ShimmerHelper().buildBasicShimmer(height: 150):
          SizedBox(
            width: 250,
            child: Column(
              children: [
                AppSummaryTextWidget(
                    title: 'SUBTOTAL',
                    amount: "${detailsController.orderDetailsData.value.subtotal}"),
                // const Gap(AppSizes.xs),
                // AppSummaryTextWidget(
                //     title: 'TAX',
                //     amount: detailsController.purchaseHistoryDetails.value.data![0].tax!),
                const Gap(AppSizes.xs),
                AppSummaryTextWidget(
                    title: 'SHIPPING COST',
                    amount: "${detailsController.orderDetailsData.value.shippingCost}"),
                const Gap(AppSizes.xs),
                AppSummaryTextWidget(
                    title: 'DISCOUNT',
                    amount: "${detailsController.orderDetailsData.value.couponDiscount}"),
                const Gap(AppSizes.xs),
                Visibility(
                  visible: detailsController.orderDetailsData.value.redeemPoint! > 0,
                  child: AppSummaryTextWidget(
                      title: 'REDEEM POINT',
                      amount: "৳${detailsController.orderDetailsData.value.redeemPoint}"),
                ),
                const Gap(AppSizes.xs),
                 SizedBox(
                  width: 270,
                  child: AppDividersStyle.fullFlatAppDivider,
                ),
                const Gap(AppSizes.xs),
                AppSummaryTextWidget(
                    title: 'GRAND TOTAL',
                    amount: "${detailsController.orderDetailsData.value.grandTotal}"),
                const Gap(AppSizes.xl),
              ],),
          );
        }
      ),
    );
  }
}

