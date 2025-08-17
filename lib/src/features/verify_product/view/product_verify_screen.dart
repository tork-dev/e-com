import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';

import '../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../common/styles/app_dividers.dart';
import '../../../common/styles/skeleton_style.dart';
import '../../../common/widgets/buttons/app_buttons.dart';
import '../../../common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../controller/product_verify_controller.dart';

class ProductVerifyScreen extends StatelessWidget {
  const ProductVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductVerifyController productVerifyController = Get.put(
      ProductVerifyController(),
    );
    return AppLayoutWithBackButton(
      title: Text("Verify Product", style: TextStyle(color: AppColors.white)),
      centerTitle: true,
      backgroundColor: AppColors.primary,
      leadingIconColor: AppColors.white,
      body: Column(
        children: [
          Gap(AppSizes.md),
          Obx(() {
            return AppListViewLayout(
              itemCount:
                  productVerifyController.isLoading.value
                      ? 5
                      : productVerifyController
                          .productVerifyListResponse
                          .value
                          .data!
                          .isEmpty
                      ? 1
                      : productVerifyController
                          .productVerifyListResponse
                          .value
                          .data!
                          .length,
              builderFunction: (context, index) {
                return productVerifyController.isLoading.value
                    ? ShimmerHelper().buildBasicShimmer(height: 100)
                    : productVerifyController
                        .productVerifyListResponse
                        .value
                        .data!
                        .isEmpty
                    ? Center(
                      child: Text(
                        "No Product Found To Verify",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    )
                    : AppCardContainer(
                      hasBorder: true,
                      borderColor: AppColors.grey,
                      padding: const EdgeInsets.all(AppSizes.md),
                      borderRadius: AppSizes.cardRadiusSm,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${productVerifyController.productVerifyListResponse.value.data![index].productName}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Gap(AppSizes.sm),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        '${productVerifyController.productVerifyListResponse.value.data![index].quantity} item',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                    ),
                                    GetBuilder<ProductVerifyController>(
                                      builder: (controller) {
                                        return Visibility(
                                          visible:
                                              !controller
                                                  .productVerifyListResponse
                                                  .value
                                                  .data![index]
                                                  .isAuthenticReview! ||
                                              controller
                                                  .productVerifyListResponse
                                                  .value
                                                  .data![index]
                                                  .canUpdateAuthenticReview!,
                                          child: AppCardContainer(
                                            onTap: () {
                                              print("Submit");
                                              showFeedbackDialog(
                                                context: context,
                                                index: index,
                                                controller:
                                                    productVerifyController,
                                              );
                                            },
                                            padding: const EdgeInsets.all(
                                              AppSizes.sm,
                                            ),
                                            borderRadius: AppSizes.cardRadiusXs,
                                            backgroundColor:
                                                AppColors.greenButton,
                                            child: Text(
                                              !controller
                                                      .productVerifyListResponse
                                                      .value
                                                      .data![index]
                                                      .canUpdateAuthenticReview!
                                                  ? 'Verify product'
                                                  : 'Update Verify',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelMedium!.apply(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
          }),
        ],
      ),
    );
  }

  void showFeedbackDialog({
    BuildContext? context,
    required int index,
    required ProductVerifyController controller,
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
                        if (controller.isAuthentic.value == 0 &&
                            text!.isEmpty) {
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
                          print("index $index");
                          controller.submitFeedback(index: index);
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
}
