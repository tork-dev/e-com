import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_without_appbar/layout_without_appbar.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../common/widgets/containers/card_container.dart';
import '../../../utils/firebase/gtm_events.dart';
import '../../../utils/logging/logger.dart';
import '../../purchase_history/controller/purchase_history_details_controller.dart';
import '../../purchase_history/view/purchace_history.dart';
import 'widget/status_section_details.dart';

class AppOrderStatusScreen extends StatelessWidget {
  final String statusString;
  final bool status;
  final int orderId;

  const AppOrderStatusScreen(
      {super.key,
      required this.statusString,
      this.status = false,
      required this.orderId});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(PurchaseHistoryDetailsController());
    controller.onRefresh(orderId);

    return AppLayoutWithoutAppBar(
        title: const Text(
          'Order Status',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        body: Obx(() {
          if (status == true &&
              controller.orderDetailsData.value.products != null) {
            final List<Map<String, dynamic>> items =
                controller.orderDetailsData.value.products!.map((item) {
              return {
                'item_id': item.slug,
                'price': double.parse(
                    item.price!.toString()),
                'quantity': item.quantity,
              };
            }).toList();
            Log.d(items.toString());

            EventLogger().logPurchaseEvent(
              items, // pass directly, not jsonEncode
              double.parse(
                controller.orderDetailsData.value.grandTotal!.toString()
              ),
                orderId.toString()
            );
          }
          return controller.orderDetailsData.value.products == null
              ? AppListViewLayout(
                  itemCount: 5,
                  builderFunction: (context, index) =>
                      ShimmerHelper().buildBasicShimmer(height: 150))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppCardContainer(
                      padding: const EdgeInsets.all(AppSizes.md),
                      borderWidth: 3,
                      borderColor: status ? Colors.green : Colors.red,
                      hasBorder: true,
                      child: Row(
                        children: [
                          AppButtons.smallRoundButton(
                              onPressed: () {},
                              buttonColor: status ? Colors.green : Colors.red,
                              buttonChild:
                                  Icon(status ? Icons.done : Icons.close)),
                          const Gap(AppSizes.sm),
                          Text(
                            statusString,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Gap(AppSizes.xs),
                    Visibility(
                      visible: status,
                      child: Text(
                        textAlign: TextAlign.center,
                        '🎉 Congrats!\n You’ll get ${controller.orderDetailsData.value
                           .rewardPoint} points after delivery!',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: AppColors.warning),
                      ),
                    ),
                    Visibility(
                      visible: status,
                      child: Column(
                        children: [
                          const Gap(AppSizes.defaultSpace),
                          Text('Order Summary',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          const Gap(AppSizes.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Number',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                controller
                                    .orderDetailsData.value.id
                                    .toString(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          ),
                          const Gap(AppSizes.md),
                          AppOrderStatusDetailsSection(
                            title: 'Subtotal',
                            subTitle: "${controller.orderDetailsData.value.subtotal}",
                          ),
                          AppOrderStatusDetailsSection(
                            title: 'Coupon Discount',
                            subTitle: "${controller.orderDetailsData.value.couponDiscount}",
                          ),
                          Visibility(
                            visible: controller.orderDetailsData.value.redeemPoint! >
                                0,
                            child: AppOrderStatusDetailsSection(
                              title: 'Redeem Point',
                              subTitle: "৳${controller.orderDetailsData.value.redeemPoint!}",
                            ),
                          ),
                          AppOrderStatusDetailsSection(
                            title: 'Delivery Charge',
                            subTitle: "${controller.orderDetailsData.value.shippingCost}",
                          ),
                          AppOrderStatusDetailsSection(
                            title: 'Total',
                            subTitle: "${controller.orderDetailsData.value.grandTotal}",
                          ),
                        ],
                      ),
                    ),
                    const Gap(AppSizes.lg),
                    Visibility(
                      visible: status,
                      child: SizedBox(
                          width: 200,
                          child: AppButtons.largeFlatFilledButton(
                              onPressed: () {
                                Get.offAll(() => const PurchaseHistory(
                                      backToHome: true,
                                    ));
                              },
                              buttonText: 'Order History',
                              backgroundColor: AppColors.secondary)),
                    ),
                    const Gap(AppSizes.md),
                    SizedBox(
                        width: 200,
                        child: AppButtons.largeFlatFilledButton(
                            onPressed: () {
                              Get.offAllNamed("/home");
                            },
                            buttonText: 'Home',
                            backgroundColor: AppColors.secondary))
                  ],
                );
        }));
  }
}
