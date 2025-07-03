import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
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
            :AppCardContainer(
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
                                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.xs),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withAlpha(51),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${detailsItemController.purchaseHistoryItemDetails.value.data![index].quantity} item',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${detailsItemController.purchaseHistoryItemDetails.value.data![index].price}',
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            AppCardContainer(
                              onTap: (){
                                showFeedbackDialog(context);
                              },
                              padding: const EdgeInsets.all(AppSizes.sm),
                              borderRadius: AppSizes.cardRadiusXs,
                              backgroundColor: AppColors.success,
                              child: Text(
                                'Verify product',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(color: AppColors.white),
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
          });
    });
  }
}


void showProductAuthenticityDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: const Color(0xFFFFF8F0), // Light cream tone
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                "Was your product authentic?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3C2A1E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Your feedback helps others shop safely.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Authentic Button
              
              AppCardContainer(
                width: double.infinity,
                padding: EdgeInsets.all(AppSizes.md),
                backgroundColor: Color(0xFFF3E8D4),
                  hasBorder: true,
                  borderColor: AppColors.primary,
                  borderWidth: 1,
                  child: Text("Yes, it felt 100% authentic", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),

              const Gap(AppSizes.spaceBtwDefaultItems),

              AppCardContainer(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppSizes.md),
                  hasBorder: true,
                  borderColor: Color(0xFF995A3C),
                  borderWidth: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Color(0xFF995A3C), size: AppSizes.iconMd,),
                      Gap(AppSizes.sm),
                      Text("No, I have concerns", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Color(0xFF995A3C), fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                    ],
                  )),

              const Gap(AppSizes.md),

              // Feedback TextField
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF3E2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  maxLines: 3,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Tell us what you liked or what seemed off\nIt matched what I’ve used before / Packaging looked different…",
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Image + Stars
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.photo_camera),
                  ),
                  const Text("Want to show your product?"),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => const Icon(Icons.star, color: Colors.amber, size: 28),
                ),
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF702D3A),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Submit report", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void showFeedbackDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd)),
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
                style: Theme.of(context).textTheme.headlineMedium
              ),

              const Gap(AppSizes.md),

              // Authenticity Button
              AppCardContainer(
                  padding: const EdgeInsets.all(AppSizes.md),
                  hasBorder: true,
                  borderColor: AppColors.primary,
                  backgroundColor: AppColors.whitePink,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: AppColors.primary, size: AppSizes.iconMd,),
                  Gap(AppSizes.sm),
                  Text(
                    "Yes, it's 100% authentic",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              )),
              const Gap(AppSizes.spaceBtwDefaultItems),
              AppCardContainer(
                  padding: const EdgeInsets.all(AppSizes.md),
                  hasBorder: true,
                  borderColor: AppColors.lightGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: AppSizes.iconMd,),
                      Gap(AppSizes.sm),
                      Text(
                        "No, I have concerns",
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                    ],
                  )),

              const Gap(AppSizes.md),

              // Note Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Note", style: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: 6),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Tell us what you liked or what seemed off. It matched what I’ve used before / Packaging looked different…",
                  hintStyle: Theme.of(context).textTheme.bodySmall?.apply(color: AppColors.darkGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),

              const SizedBox(height: 20),

              // Rating
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Rate Your Satisfaction",
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  5,
                      (index) => const Icon(Icons.star, color: Colors.amber),
                ),
              ),

              const SizedBox(height: 20),

              // Upload Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Upload Photo (Optional)",
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: 8),
              DottedBorder(
                // borderType: BorderType.RRect,
                // radius: const Radius.circular(12),
                // dashPattern: [6, 4],
                // color: Colors.grey,
                child: Container(
                  height: 80,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: "Tap to ",
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: "upload photo",
                          style: TextStyle(color: Colors.blue[700]),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A2E),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Submit Feedback"),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}





