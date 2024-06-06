import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/purchase_history/controller/purchase_history_controller.dart';
import 'package:torganic/src/features/purchase_history/view/purchase_history_details.dart';
import 'package:torganic/src/features/purchase_history/view/widget/payment_status_indicator.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class AppPurchaseHistoryCard extends StatelessWidget {
  const AppPurchaseHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseHistoryController = PurchaseHistoryController.instance;
    final bottomNavigationController = ConvexBottomNavController.instance;
    return Obx(() {
      return AppListViewLayout(
          itemCount:
              purchaseHistoryController.purchaseHistoryList.value.data == null
                  ? 5
                  : purchaseHistoryController
                      .purchaseHistoryList.value.data!.length,
          builderFunction: (context, index) {
            return purchaseHistoryController.purchaseHistoryList.value.data ==
                    null
                ? ShimmerHelper().buildBasicShimmer(height: 125)
                : AppCardContainer(
                    onTap: () {
                      Get.to(() => PurchaseHistoryDetails(
                            orderId: purchaseHistoryController
                                .purchaseHistoryList.value.data![index].id!,
                          ));
                    },
                    padding: const EdgeInsets.all(AppSizes.md),
                    width: AppHelperFunctions.screenWidth(),
                    hasBorder: true,
                    borderColor: AppColors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Order Number: ${purchaseHistoryController.purchaseHistoryList.value.data![index].id}'),
                            const Gap(AppSizes.xs),
                            Row(
                              children: [
                                const Text('Payment Status- '),
                                Text(
                                  '${purchaseHistoryController.purchaseHistoryList.value.data![index].paymentStatus}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const Gap(AppSizes.sm),
                                PaymentStatusIndicator(
                                  paymentStatus: purchaseHistoryController
                                      .purchaseHistoryList
                                      .value
                                      .data![index]
                                      .paymentStatus!,
                                )
                              ],
                            ),
                            const Gap(AppSizes.xs),
                            Text(
                                'Delivery Status: ${purchaseHistoryController.purchaseHistoryList.value.data![index].deliveryStatusString}'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${purchaseHistoryController.purchaseHistoryList.value.data![index].grandTotal}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .apply(color: AppColors.primary),
                            ),
                            const Gap(AppSizes.xs),
                            Text(
                                '${purchaseHistoryController.purchaseHistoryList.value.data![index].date}'),
                            const Gap(AppSizes.xs),
                            InkWell(
                              onTap: () {
                                purchaseHistoryController
                                    .getReorderResponse(
                                        purchaseHistoryController
                                            .purchaseHistoryList
                                            .value
                                            .data![index]
                                            .id!)
                                    .then((value) => {
                                          AppHelperFunctions.showToast(
                                              purchaseHistoryController
                                                  .reOrderResponse
                                                  .value
                                                  .message!),
                                  Get.back(),
                                  bottomNavigationController.jumpToTab(2)
                                        });
                              },
                              child: AppCardContainer(
                                padding: const EdgeInsets.all(AppSizes.sm),
                                applyRadius: false,
                                backgroundColor: AppColors.black,
                                child: Text(
                                  'Re-order',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .apply(color: AppColors.white),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ));
          });
    });
  }
}
