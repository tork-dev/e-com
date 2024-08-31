import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/spinner_wheel/controller/spinner_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/validators/validation.dart';

class AppSpinnerWheelAlert extends StatelessWidget {
  const AppSpinnerWheelAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final spinController = Get.put(SpinnerController());
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return SingleChildScrollView(
      child: Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        //contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(AppSizes.md),
        backgroundColor: AppColors.popUpBackground,
        child: AppCardContainer(
          padding: const EdgeInsets.only(bottom: AppSizes.xl),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: Form(
                  key: spinController.phoneKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: AppCardContainer(
                          margin: const EdgeInsets.only(top: AppSizes
                              .appBarHeight),
                          height: 300,
                          width: 300,
                          child: FortuneWheel(
                            selected: spinController.selected.stream,
                            animateFirst: false,
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
                              for (var it in spinController.items)
                                FortuneItem(
                                    child: Text(it),
                                    style: FortuneItemStyle(
                                      color: AppColors().colorList[
                                      spinController.items.indexOf(it)],
                                      borderWidth: 0,
                                    )),
                            ],
                            onAnimationEnd: () {
                              spinController.selectedCoupon.value =
                              spinController.items[spinController.selectedIndex
                                  .value];
                              print(spinController.selectedCoupon.value);
                              Get.back();
                              AppHelperFunctions.showPopUpAlert(
                                imgUrl: '',
                                  title: 'Done',
                                  subTitle: 'Done',
                                  leftButtonName: 'Cancel',
                                  rightButtonName: 'OK',
                                  onRightPress: (){},
                                  onLeftPress: (){});
                            },
                          ),
                        ),
                      ),
                      const Gap(AppSizes.defaultSpace),
                      Text(
                        'Spin to win!',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium,
                      ),
                      const Gap(AppSizes.sm),
                      Text(
                        'Enter your phone number for the chance to win!',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall!
                            .apply(color: AppColors.secondary),
                      ),
                      const Gap(AppSizes.defaultSpace),
                      TextFormField(
                        controller: spinController.phoneNumberController,
                        cursorColor: AppColors.primary,
                        validator: (value) =>
                            AppValidator.validatePhoneNumber(value),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSizes.md,
                              vertical: AppSizes.spaceBtwDefaultItems),
                          hintText: '01*********',
                          fillColor: AppColors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(width: 0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(width: 0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(width: 0)),
                        ),
                      ),
                      const Gap(AppSizes.defaultSpace),
                      Obx(() {
                        return CheckboxListTile(
                          value: spinController.isChecked.value,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            spinController.isChecked.value =
                            !spinController.isChecked.value;
                          },
                          title: const Text(
                              'I’ve read and agree to the Terms and the Privacy Policy.'),
                        );
                      }
                      ),
                      const Gap(AppSizes.spaceBtwSections),
                      AppButtons.largeFlatFilledButton(
                          onPressed: () {
                            spinController.tryLuck();
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
                    applyRadius: false,
                    backgroundColor: AppColors.grey,
                    height: 40,
                    width: 40,
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.clear))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
