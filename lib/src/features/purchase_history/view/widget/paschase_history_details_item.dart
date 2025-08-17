import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/purchase_history/controller/purchase_history_details_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppPurchaseHistoryDetailsItem extends StatelessWidget {
  const AppPurchaseHistoryDetailsItem({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsItemController = PurchaseHistoryDetailsController.instance;
    return Obx(() {
      return AppListViewLayout(
        itemCount:
            detailsItemController.purchaseHistoryItemDetails.value.data == null
                ? 5
                : detailsItemController
                    .purchaseHistoryItemDetails
                    .value
                    .data!
                    .length,
        builderFunction: (context, index) {
          return detailsItemController.purchaseHistoryItemDetails.value.data ==
                  null
              ? ShimmerHelper().buildBasicShimmer(height: 100)
              : AppCardContainer(
            onTap: (){
              // Get.toNamed('/product/${detailsItemController.purchaseHistoryItemDetails.value.data![index].productSlug}',
              //     parameters: {'prevRoute': prevRoute});
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
                            '${detailsItemController.purchaseHistoryItemDetails.value.data![index].productName}',
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
                                  '${detailsItemController.purchaseHistoryItemDetails.value.data![index].quantity} item',
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Text(
                                '${detailsItemController.purchaseHistoryItemDetails.value.data![index].price}',
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
      );
    });
  }
}

