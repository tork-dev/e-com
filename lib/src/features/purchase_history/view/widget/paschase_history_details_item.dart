import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/purchase_history/controller/purchase_history_details_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppPurchaseHistoryDetailsItem extends StatelessWidget {
  const AppPurchaseHistoryDetailsItem({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsItemController = PurchaseHistoryDetailsController.instance;
    return Obx(() {
      return Column(
        children: [
          AppListViewLayout(
            itemCount:
            detailsItemController.orderDetailsData.value.comboProducts == null
                ? 1
                : detailsItemController
                .orderDetailsData
                .value
                .comboProducts!
                .length,
            builderFunction: (context, index) {
              return detailsItemController.orderDetailsData.value.comboProducts ==
                  null
                  ? ShimmerHelper().buildBasicShimmer(height: 100)
                  : AppCardContainer(
                onTap: (){
                  Get.toNamed('/product/${detailsItemController.orderDetailsData.value.comboProducts![index].comboProduct!.slug}',
                      parameters: {'prevRoute': "order/${detailsItemController.orderDetailsData.value.id}"});
                  // Get.toNamed("/");
                },
                hasBorder: true,
                padding: const EdgeInsets.all(AppSizes.md),
                borderRadius: 12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${detailsItemController.orderDetailsData.value.comboProducts![index].comboProduct?.name}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Gap(AppSizes.sm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.sm,
                                  vertical: AppSizes.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(51),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${detailsItemController.orderDetailsData.value.comboProducts![index].quantity} item',
                                  style:
                                  Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Text(
                                '${detailsItemController.orderDetailsData.value.comboProducts![index].subTotal}',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium!.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          AppListViewLayout(
            itemCount:
                detailsItemController.orderDetailsData.value.products == null
                    ? 5
                    : detailsItemController
                        .orderDetailsData
                        .value
                        .products!
                        .length,
            builderFunction: (context, index) {
              return detailsItemController.orderDetailsData.value.products ==
                      null
                  ? ShimmerHelper().buildBasicShimmer(height: 100)
                  : AppCardContainer(
                onTap: (){
                  Get.toNamed('/product/${detailsItemController.orderDetailsData.value.products![index].slug}',
                      parameters: {'prevRoute': "order/${detailsItemController.orderDetailsData.value.id}"});
                  // Get.toNamed("/");
                },
                    hasBorder: true,
                    padding: const EdgeInsets.all(AppSizes.md),
                    borderRadius: 12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${detailsItemController.orderDetailsData.value.products![index].productName}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Gap(AppSizes.sm),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.sm,
                                      vertical: AppSizes.xs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withAlpha(51),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${detailsItemController.orderDetailsData.value.products![index].quantity} item',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  Text(
                                    '${detailsItemController.orderDetailsData.value.products![index].price}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium!.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
            },
          ),
        ],
      );
    });
  }
}

