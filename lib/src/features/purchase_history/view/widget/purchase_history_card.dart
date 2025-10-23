import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/bottom_navigation/convex_bottom_navigation.dart';
import 'package:kirei/src/features/bottom_navigation/google_nav_bar.dart';
import 'package:kirei/src/features/purchase_history/controller/purchase_history_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class AppPurchaseHistoryCard extends StatelessWidget {
  const AppPurchaseHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseHistoryController = PurchaseHistoryController.instance;
    return Obx(() {
      return AppListViewLayout(
        itemCount:
            purchaseHistoryController.hittingApi.value
                ? 5
                : purchaseHistoryController
                    .purchaseHistoryList
                    .value
                    .data!
                    .length,
        builderFunction: (context, index) {
          return purchaseHistoryController.purchaseHistoryList.value.data ==
                  null
              ? ShimmerHelper().buildBasicShimmer(height: 125)
              : AppCardContainer(
                onTap: () {
                  Get.toNamed(
                    '/order/${purchaseHistoryController.purchaseHistoryList.value.data![index].id!}',
                  );
                },
                padding: const EdgeInsets.all(AppSizes.md),
                width: AppHelperFunctions.screenWidth(),
                hasBorder: true,
                borderColor: AppColors.lightGrey,
                backgroundColor: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Number: ${purchaseHistoryController.purchaseHistoryList.value.data![index].id}',
                        ),
                        const Gap(AppSizes.xs),
                        Row(
                          children: [
                            const Text('Payment Status- '),
                            Text(
                              '${purchaseHistoryController.purchaseHistoryList.value.data![index].paymentStatus}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Gap(AppSizes.sm),
                            // PaymentStatusIndicator(
                            //   paymentStatus: "pending"
                            // ),
                          ],
                        ),
                        const Gap(AppSizes.xs),
                        Text(
                          'Delivery Status: ${purchaseHistoryController.purchaseHistoryList.value.data![index].deliveryStatusString}',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${purchaseHistoryController.purchaseHistoryList.value.data![index].grandTotal}',
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: AppColors.primary,
                          ),
                        ),
                        const Gap(AppSizes.xs),
                        Text(
                          '${purchaseHistoryController.purchaseHistoryList.value.data![index].date}',
                        ),
                        const Gap(AppSizes.xs),
                        Row(
                          spacing: AppSizes.sm,
                          children: [
                            InkWell(
                              onTap: () {
                                purchaseHistoryController
                                    .getReorderResponse(
                                      purchaseHistoryController
                                          .purchaseHistoryList
                                          .value
                                          .data![index]
                                          .id!,
                                    )
                                    .then(
                                      (value) => {
                                        AppHelperFunctions.showToast(
                                          purchaseHistoryController
                                              .reOrderResponse
                                              .value
                                              .message!,
                                        ),
                                        Get.offAll(
                                          () =>
                                              const GoogleNavBar(pageIndex: 2),
                                        ),
                                      },
                                    );
                              },
                              child: AppCardContainer(
                                padding: const EdgeInsets.all(AppSizes.sm),
                                borderRadius: AppSizes.cardRadiusXs,
                                backgroundColor: AppColors.black,
                                child: Text(
                                  'Re-order',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(color: AppColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
        },
      );
    });
  }
}
