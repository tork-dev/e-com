import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/purchase_history_details_controller.dart';
import 'payment_status_indicator.dart';

class AppOrderShippingDetailsCard extends StatelessWidget {
  const AppOrderShippingDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = PurchaseHistoryDetailsController.instance;
    return Obx(() {
      return detailsController.purchaseHistoryDetails.value.data == null
          ? ShimmerHelper().buildBasicShimmer(height: 250)
          : AppCardContainer(
              padding: const EdgeInsets.all(AppSizes.md),
              hasBorder: true,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Number',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${detailsController.purchaseHistoryDetails.value.data![0].id!}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .apply(color: AppColors.primary),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping Method',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            detailsController.purchaseHistoryDetails.value
                                .data![0].shippingType!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .apply(color: AppColors.primary),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Gap(AppSizes.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Date',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                              detailsController
                                  .purchaseHistoryDetails.value.data![0].date!,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Payment Method',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                              detailsController.purchaseHistoryDetails.value
                                  .data![0].paymentType!,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                  const Gap(AppSizes.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Status',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Row(
                            children: [
                              Text(
                                  detailsController.purchaseHistoryDetails.value
                                      .data![0].paymentStatus!,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const Gap(AppSizes.xs),
                              PaymentStatusIndicator(
                                paymentStatus: detailsController
                                    .purchaseHistoryDetails
                                    .value
                                    .data![0]
                                    .paymentStatus!,
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Delivery Status',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                              detailsController.purchaseHistoryDetails.value
                                  .data![0].deliveryStatusString!,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                  const Gap(AppSizes.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipping Address',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                                'Name: ${detailsController.purchaseHistoryDetails.value
                                    .data![0].shippingAddress!.name}',
                                style:
                                Theme.of(context).textTheme.bodyMedium),
                            Text(
                                'Address: ${detailsController.purchaseHistoryDetails.value
                                    .data![0].shippingAddress!.address}',
                                style:
                                Theme.of(context).textTheme.bodyMedium),
                            Text(
                                'City: ${detailsController.purchaseHistoryDetails.value
                                    .data![0].shippingAddress!.city}',
                                style:
                                Theme.of(context).textTheme.bodyMedium),
                            Text(
                                'Area: ${detailsController.purchaseHistoryDetails.value
                                    .data![0].shippingAddress!.state}',
                                style:
                                Theme.of(context).textTheme.bodyMedium),
                            Text(
                                'Phone: ${detailsController.purchaseHistoryDetails.value
                                    .data![0].shippingAddress!.phone}',
                                style:
                                Theme.of(context).textTheme.bodyMedium),

                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Amount',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                              detailsController.purchaseHistoryDetails.value
                                  .data![0].grandTotal!,
                              style: Theme.of(context).textTheme.titleLarge!.apply(color: AppColors.primary)),
                        ],
                      ),
                    ],
                  ),
                  const Gap(AppSizes.spaceBtwItems),
                  AppButtons.largeFlatFilledButton(
                    backgroundColor: AppColors.secondary,
                      onPressed: (){},
                      buttonText: 'Re-Order'),
                  const Gap(AppSizes.spaceBtwItems),
                  Visibility(
                    visible: detailsController.purchaseHistoryDetails.value.data![0].deliveryStatus == 'Processing',
                      child: AppButtons.largeFlatOutlineButton(
                      onPressed: (){},
                      buttonText: 'Update Info'))
                ],
              ));
    });
  }
}
