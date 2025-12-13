import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/spin/controller/spinner_controller.dart';
import 'package:kirei/src/features/spinner_wheel/controller/spinner_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/device/device_utility.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/logging/logger.dart';
import '../../../utils/validators/validation.dart';
import '../../authentication/views/log_in/repository/login_repository.dart';

class AppSpinnerWheelForSale extends StatelessWidget {
  const AppSpinnerWheelForSale({super.key});

  @override
  Widget build(BuildContext context) {
    final spinController = Get.put(SaleSpinnerController());
      return AppLayoutWithBackButton(
        bodyBackgroundColor: AppColors.secondaryBackground,
        body: Padding(
          padding: const .symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.md,
          ),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              Text(
                'Spin to win!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Obx( () {
                  return Center(
                    child: spinController.isLoading.value
                        ? ShimmerHelper().buildBasicShimmer(height: 200)
                        : AppCardContainer(
                            margin: const .only(top: AppSizes.appBarHeight),
                            height: 350,
                            width: 350,
                            child: FortuneWheel(
                              selected: spinController.selected.stream,
                              animateFirst: false,
                              physics: NoPanPhysics(),
                              indicators: const <FortuneIndicator>[
                                FortuneIndicator(
                                  alignment: Alignment.topCenter,
                                  child: TriangleIndicator(
                                    color: Colors.white,
                                    width: 20,
                                    height: 24.0,
                                    elevation: 0,
                                  ),
                                ),
                              ],
                              items: [
                                for (var item in spinController.couponList)
                                  FortuneItem(
                                    child: SizedBox(
                                      width: 70,
                                        // height: 35,
                                        child: Text(item, maxLines: 2, overflow: .ellipsis,)),
                                    style: FortuneItemStyle(
                                      color: AppColors().colorList[
                                      spinController.couponList
                                          .indexOf(item)],
                                      borderWidth: 0,
                                    ),
                                  ),
                              ],
                              onAnimationEnd: () {
                                Log.d(
                                  'animation end ${spinController.selectedCoupon.value}',
                                );

                                if (spinController
                                        .selectedCouponResponse
                                        .value
                                        .result ==
                                    true) {
                                  spinController.selectedCoupon.value =
                                      spinController.couponList[spinController
                                          .selectedIndex
                                          .value];
                                }

                                Log.d(
                                  'response expires message ${spinController
                                      .selectedCouponResponse
                                      .value
                                      .data
                                      ?.expiredMessage}',
                                );
                                AppHelperFunctions.showSpinnerCoupon(
                                  title:
                                      spinController
                                          .selectedCouponResponse
                                          .value
                                          .data
                                          ?.title ??
                                      '',
                                  couponCode: spinController
                                      .selectedCouponResponse
                                      .value
                                      .data
                                      ?.couponCode,
                                  expireMessage:
                                      spinController
                                          .selectedCouponResponse
                                          .value
                                          .data
                                          ?.expiredMessage ??
                                      '',
                                  onCouponPress: () {
                                    FlutterClipboard.copy(
                                      spinController
                                              .selectedCouponResponse
                                              .value
                                              .data
                                              ?.couponCode ??
                                          '',
                                    ).then(
                                      (value) => AppHelperFunctions.showToast(
                                        'Coupon copied',
                                      ),
                                    );
                                  },
                                  subTitle:
                                      spinController
                                          .selectedCouponResponse
                                          .value
                                          .data
                                          ?.description ??
                                      '',
                                  imgUrl:
                                      spinController
                                          .selectedCouponResponse
                                          .value
                                          .data
                                          ?.image ??
                                      '',
                                );
                              },
                            ),
                          ),
                  );
                }
              ),
              const Gap(AppSizes.defaultSpace),
              const Gap(AppSizes.defaultSpace),
              AppButtons.largeFlatFilledButton(
                backgroundColor: AppColors.buttonPrimary,
                onPressed: () {
                  spinController.getSelectedCouponResponse();
                },
                buttonText: "Spin",
              ),
            ],
          ),
        ),
      );
  }
}
