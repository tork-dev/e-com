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
      return AppListViewLayout(
          itemCount:
              detailsItemController.purchaseHistoryItemDetails.value.data ==
                      null
                  ? 5
                  : detailsItemController
                      .purchaseHistoryItemDetails.value.data!.length,
          builderFunction: (context, index) {
            return detailsItemController
                        .purchaseHistoryItemDetails.value.data ==
                    null
                ? ShimmerHelper().buildBasicShimmer(height: 100)
                : AppCardContainer(
                    hasBorder: true,
                    padding: const EdgeInsets.all(AppSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${detailsItemController.purchaseHistoryItemDetails.value.data![0].productName}'),
                        const Gap(AppSizes.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text('${detailsItemController.purchaseHistoryItemDetails.value.data![0].quantity} item',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text('${detailsItemController.purchaseHistoryItemDetails.value.data![0].price}',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: AppColors.primary),)
                          ],)
                      ],
                    ));
          });
    });
  }
}
