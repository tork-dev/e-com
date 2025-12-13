import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../controller/my_coupons_controller.dart';

class MyCouponsScreen extends StatelessWidget {
  const MyCouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyCouponsController controller = Get.put(MyCouponsController());
    return AppLayoutWithBackButton(
      title: const Text(
        'My Coupons',
        style: TextStyle(color: AppColors.secondary),
      ),
      leadingIconColor: AppColors.darkerGrey,
      backgroundColor: AppColors.white,
      bodyBackgroundColor: AppColors.secondaryBackground,
      centerTitle: true,
      body: Obx(() {
        bool isCopied =
            controller.myCoupons.value.data?.any(
              (item) =>
                  item.couponCode == controller.selectedCoupon.value.couponCode,
            ) ??
            false;
        return AppListViewLayout(
          itemCount: controller.myCoupons.value.data?.length ?? 10,
          builderFunction: (context, index) =>
              controller.myCoupons.value.data == null
              ? ShimmerHelper().buildBasicShimmer(height: 50)
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    AppCardContainer(
                      height: 170,
                      width: double.infinity,
                      margin: .only(top: AppSizes.md),
                      padding: const .all(AppSizes.md),
                      backgroundColor: AppColors.white,
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: .center,
                              mainAxisAlignment: .center,
                              children: [
                                Text(
                                  controller
                                              .myCoupons
                                              .value
                                              .data?[index]
                                              .discount ==
                                          0
                                      ? "Free"
                                      : "${controller.myCoupons.value.data?[index].discount} ${controller.myCoupons.value.data?[index].couponType == "percent" ? "%" : "TK"} OFF",
                                  textAlign: .center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.apply(color: AppColors.primary),
                                ),
                                Text(
                                  "${controller.myCoupons.value.data?[index].title ?? ""}",
                                  textAlign: .center,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.apply(color: AppColors.darkGrey),
                                ),
                              ],
                            ),
                          ),
                          AppDividersStyle.verticalDashedLine(height: 130),
                          SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: .start,
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Text(
                                  "${controller.myCoupons.value.data?[index].couponEvent}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.apply(color: AppColors.secondary),
                                ),
                                Gap(AppSizes.xs),
                                Text(
                                  "Expires: ${controller.myCoupons.value.data![index].expiredAt!}",
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.apply(color: AppColors.darkGrey),
                                ),
                                Gap(AppSizes.sm),
                                Row(
                                  mainAxisAlignment: .end,
                                  children: [
                                    AppCardContainer(
                                      onTap: () {
                                        controller
                                                .myCoupons
                                                .value
                                                .data![index]
                                                .isUsed!
                                            ? null
                                            : isCopied
                                            ? FlutterClipboard.copy(
                                                controller
                                                    .myCoupons
                                                    .value
                                                    .data![index]
                                                    .couponCode!,
                                              ).then(
                                                (value) =>
                                                    controller
                                                        .selectedCoupon
                                                        .value = controller
                                                        .myCoupons
                                                        .value
                                                        .data![index],
                                              )
                                            : Get.offAllNamed("/shop");
                                      },
                                      padding: const EdgeInsets.symmetric(
                                        vertical: AppSizes.sm,
                                        horizontal: AppSizes.md,
                                      ),
                                      borderRadius: AppSizes.cardRadiusXs,
                                      backgroundColor:
                                          controller
                                              .myCoupons
                                              .value
                                              .data![index]
                                              .isUsed!
                                          ? AppColors.buttonDisabled
                                          : isCopied
                                          ? AppColors.primary
                                          : AppColors.secondary,
                                      child: Text(
                                        controller
                                                .myCoupons
                                                .value
                                                .data![index]
                                                .isUsed!
                                            ? " Used "
                                            : isCopied
                                            ? 'Copy Now'
                                            : 'Use Now',
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
                    ),
                    Visibility(
                      visible: controller.myCoupons.value.data![index].isUsed!,
                      child: AppCardContainer(
                        width: double.infinity,
                        height: 170,
                        margin: .only(top: AppSizes.md),
                        backgroundColor: AppColors.secondary.withAlpha(
                          AppHelperFunctions.toAlpha(.5),
                        ),
                        child: Center(
                          child: Transform.rotate(
                            angle:
                                -30 * 3.1415926535 / 180, // 45° left rotation
                            child: AppCardContainer(
                              hasBorder: true,
                              borderWidth: 3,
                              borderColor: AppColors.darkerGrey,
                              padding: EdgeInsets.all(AppSizes.sm),
                              child: Text(
                                "USED",
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.apply(color: AppColors.darkerGrey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
