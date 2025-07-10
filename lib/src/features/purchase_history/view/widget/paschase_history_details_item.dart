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
                          Gap(AppSizes.xs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                                  const SizedBox(width: 12),
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
                              GetBuilder<PurchaseHistoryDetailsController>(builder: (controller){
                                  return Visibility(
                                    visible:
                                        !controller
                                            .purchaseHistoryItemDetails
                                            .value
                                            .data![index]
                                            .isAuthenticReview!,
                                    child: AppCardContainer(
                                      onTap: () {
                                        showFeedbackDialog(
                                          context: context,
                                          index: index,
                                          controller: detailsItemController,
                                        );
                                      },
                                      padding: const EdgeInsets.all(AppSizes.sm),
                                      borderRadius: AppSizes.cardRadiusXs,
                                      backgroundColor: AppColors.greenButton,
                                      child: Text(
                                        'Verify product',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .apply(color: AppColors.white),
                                      ),
                                    ),
                                  );
                                }
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

void showFeedbackDialog({
  BuildContext? context,
  required int index,
  required PurchaseHistoryDetailsController controller,
}) {
  showDialog(
    context: context!,
    builder:
        (_) => Dialog(
          insetPadding: EdgeInsets.all(AppSizes.md),
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Kirei Logo (Placeholder for now)
                  Image.asset(AppImages.lightAppLogo, height: 40),
                  const Gap(AppSizes.md),
                  AppDividersStyle.fullFlatAppDivider,
                  const Gap(AppSizes.defaultSpace),

                  // Title
                  Text(
                    "Was Your Product Authentic?",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const Gap(AppSizes.md),

                  // Authenticity Button
                  Obx(() {
                    return AppCardContainer(
                      onTap: () => controller.isAuthentic.value = 1,
                      padding: const EdgeInsets.all(AppSizes.md),
                      hasBorder: true,
                      borderColor:
                          controller.isAuthentic.value == 1
                              ? AppColors.greenButton
                              : AppColors.lightGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline_outlined,
                            color:
                                controller.isAuthentic.value == 1
                                    ? AppColors.greenButton
                                    : AppColors.textPrimary,
                            size: AppSizes.iconMd,
                          ),
                          Gap(AppSizes.sm),
                          Text(
                            "Yes, it's 100% authentic",
                            style: TextStyle(
                              color:
                                  controller.isAuthentic.value == 1
                                      ? AppColors.greenButton
                                      : AppColors.textPrimary,
                              fontWeight:
                                  controller.isAuthentic.value == 1
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  Obx(() {
                    return AppCardContainer(
                      onTap: () => controller.isAuthentic.value = 0,
                      padding: const EdgeInsets.all(AppSizes.md),
                      hasBorder: true,
                      borderColor:
                          controller.isAuthentic.value == 0
                              ? AppColors.error
                              : AppColors.lightGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color:
                                controller.isAuthentic.value == 0
                                    ? AppColors.error
                                    : AppColors.textPrimary,
                            size: AppSizes.iconMd,
                          ),
                          Gap(AppSizes.sm),
                          Text(
                            "No, I have concerns",
                            style: TextStyle(
                              color:
                                  controller.isAuthentic.value == 0
                                      ? AppColors.error
                                      : AppColors.textPrimary,
                              fontWeight:
                                  controller.isAuthentic.value == 0
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const Gap(AppSizes.md),

                  // Note Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Note",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Obx(() {
                          return Text(
                            controller.isAuthentic.value == 0 ? " *" : "",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.apply(color: AppColors.error),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    maxLines: 4,
                    controller: controller.noteController,
                    decoration: InputDecoration(
                      hintText:
                          "Tell us what you liked or what seemed off. It matched what I’ve used before / Packaging looked different…",
                      hintStyle: Theme.of(
                        context,
                      ).textTheme.bodySmall?.apply(color: AppColors.darkGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    validator: (text) {
                      if (controller.isAuthentic.value == 0 && text!.isEmpty) {
                        return "Note is required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: AppButtons.largeFlatFilledButton(
                      onPressed: () {
                        controller.submitFeedback(
                          index: index,
                        );
                      },
                      backgroundColor: AppColors.secondary,
                      buttonText: "Submit",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
