import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
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

class AppSpinnerWheelAlert extends StatelessWidget {
  const AppSpinnerWheelAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final spinController = SpinnerController.instance;

    return Obx(() {
      return spinController.couponList.length > 1
          ? SingleChildScrollView(
              child: Dialog(
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
                ),
                //contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(AppSizes.md),
                backgroundColor: AppColors.popUpBackground,
                child: AppCardContainer(
                  padding: const EdgeInsets.only(bottom: AppSizes.xl),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSizes.md),
                        child: Form(
                          key: spinController.phoneKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: AppCardContainer(
                                  margin: const EdgeInsets.only(
                                      top: AppSizes.appBarHeight),
                                  height: 300,
                                  width: 300,
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
                                      for (var it in spinController.couponList)
                                        FortuneItem(
                                            child: Text(it),
                                            style: FortuneItemStyle(
                                              color: AppColors().colorList[
                                                  spinController.couponList
                                                      .indexOf(it)],
                                              borderWidth: 0,
                                            )),
                                    ],
                                    onAnimationEnd: () {

                                      Log.d('animation end ${spinController.selectedCoupon.value}');

                                      if (spinController.selectedCouponResponse
                                              .value.result ==
                                          true) {
                                        spinController.selectedCoupon.value =
                                        spinController.couponList[
                                        spinController
                                            .selectedIndex.value];
                                      }

                                      Log.d(
                                          spinController.selectedCoupon.value);
                                      Get.back();
                                        AppHelperFunctions.showSpinnerCoupon(
                                            title: spinController
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
                                            expireMessage: spinController.selectedCouponResponse.value.data?.expiredMessage ?? '',
                                            onCouponPress: () {
                                              FlutterClipboard.copy(spinController
                                                          .selectedCouponResponse
                                                          .value
                                                          .data
                                                          ?.couponCode ??
                                                      '')
                                                  .then((value) =>
                                                      AppHelperFunctions
                                                          .showToast(
                                                              'Coupon copied'));
                                            },
                                            subTitle: spinController
                                                    .selectedCouponResponse
                                                    .value
                                                    .data
                                                    ?.description ??
                                                '',
                                            imgUrl: spinController
                                                    .selectedCouponResponse
                                                    .value
                                                    .data
                                                    ?.image ??
                                                '');
                                      }
                                  ),
                                ),
                              ),
                              const Gap(AppSizes.defaultSpace),
                              Text(
                                'Spin to win!',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const Gap(AppSizes.sm),
                              Text(
                                'Enter your phone number for the chance to win!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(color: AppColors.secondary),
                              ),
                              const Gap(AppSizes.defaultSpace),
                              TextFormField(
                                controller:
                                    spinController.phoneNumberController,
                                cursorColor: AppColors.primary,
                                validator: (value) =>
                                    AppValidator.validatePhoneNumber(value),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.md,
                                      vertical: AppSizes.spaceBtwDefaultItems),
                                  hintText: '01*********',
                                  fillColor: AppColors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
                                      borderSide: const BorderSide(width: 0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
                                      borderSide: const BorderSide(width: 0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
                                      borderSide: const BorderSide(width: 0)),
                                ),
                              ),
                              const Gap(AppSizes.defaultSpace),
                              Obx(() {
                                return CheckboxListTile(
                                  value: spinController.isChecked.value,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                  onChanged: (value) {
                                    spinController.isChecked.value =
                                        !spinController.isChecked.value;
                                  },
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("I’ve read and agree to the Terms and the"),
                                      InkWell(
                                        onTap: (){
                                          AppDeviceUtils.browseUrl("https://kireibd.com/privacy-policy");
                                        },
                                          child: const Text(" Privacy Policy.", style: TextStyle(color: AppColors.primary, decoration: TextDecoration.underline, decorationColor: AppColors.primary))),

                                    ],
                                  ),
                                );
                              }),
                              const Gap(AppSizes.spaceBtwSections),
                              AppButtons.largeFlatFilledButton(
                                backgroundColor: !spinController.isChecked.value? AppColors.buttonDisabled : AppColors.buttonPrimary,
                                  onPressed: () {
                                    if (!spinController.phoneKey.currentState!
                                        .validate()) {
                                      return;
                                    }
                                    if (!spinController.isChecked.value) {
                                      AppHelperFunctions.showToast(
                                          'Please agree to the terms and condition');
                                      return;
                                    }
                                    LoginRepository().getLoginOTPResponse(
                                        spinController
                                            .phoneNumberController.text
                                            .toString());
                                    AppHelperFunctions.showToast(
                                        'We have sent OTP to your phone.');
                                    AppHelperFunctions.verifyPhone();
                                    AppLocalStorage().saveData(
                                        LocalStorageKeys.sowedSpinner, true);

                                  },
                                  buttonText: "Try My Luck!"),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: AppSizes.sm,
                        top: AppSizes.sm,
                        child: AppCardContainer(
                            backgroundColor: AppColors.primary.withAlpha(51),
                            height: 40,
                            width: 40,
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                  AppLocalStorage().saveData(
                                      LocalStorageKeys.sowedSpinner, true);
                                },
                                child: const Icon(Icons.clear))),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              insetPadding: const EdgeInsets.all(AppSizes.md),
              backgroundColor: AppColors.popUpBackground,
              child: AppCardContainer(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppCardContainer(
                          applyRadius: false,
                          backgroundColor: AppColors.grey,
                          height: 40,
                          width: 40,
                          child: InkWell(
                              onTap: () {
                                Get.back();
                                AppLocalStorage().saveData(
                                    LocalStorageKeys.sowedSpinner, true);
                              },
                              child: const Icon(Icons.clear))),
                    ],
                  ),
                  const Gap(AppSizes.md),
                  Text(
                    'Welcome to kirei',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ]),
              ),
            );
    });
  }
}
