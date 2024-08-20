import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_without_appbar/layout_without_appbar.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../common/widgets/containers/card_container.dart';
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
        Get.put(PurchaseHistoryDetailsController(orderId: orderId));
    return AppLayoutWithoutAppBar(
        title: const Text(
          'Order Status',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        body: Obx(() {
          return controller.purchaseHistoryDetails.value.data == null
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
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: status,
                      child: Column(
                        children: [
                          const Gap(AppSizes.md),
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
                                    .purchaseHistoryDetails.value.data![0].id
                                    .toString(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          ),
                          const Gap(AppSizes.md),
                          AppOrderStatusDetailsSection(
                            title: 'Subtotal',
                            subTitle: controller.purchaseHistoryDetails.value
                                .data![0].subtotal!,
                          ),
                          AppOrderStatusDetailsSection(
                            title: 'Coupon Discount',
                            subTitle: controller.purchaseHistoryDetails.value
                                .data![0].couponDiscount!,
                          ),
                          AppOrderStatusDetailsSection(
                            title: 'Delivery Charge',
                            subTitle: controller.purchaseHistoryDetails.value
                                .data![0].shippingCost!,
                          ),
                          AppOrderStatusDetailsSection(
                            title: 'Total',
                            subTitle: controller.purchaseHistoryDetails.value
                                .data![0].grandTotal!,
                          ),
                        ],
                      ),
                    ),
                    const Gap(AppSizes.lg),
                    SizedBox(
                        width: 200,
                        child: AppButtons.largeFlatFilledButton(
                            onPressed: () {
                              Get.offAll(() => const PurchaseHistory(
                                    backToHome: true,
                                  ));
                            },
                            buttonText: 'Order History',
                            backgroundColor: AppColors.secondary)),
                    const Gap(AppSizes.md),
                    SizedBox(
                        width: 200,
                        child: AppButtons.largeFlatFilledButton(
                            onPressed: () {
                              Get.offAll(() => const HelloConvexAppBar(
                                    pageIndex: 0,
                                  ));
                            },
                            buttonText: 'Home',
                            backgroundColor: AppColors.secondary))
                  ],
                );
        }));
  }
}
