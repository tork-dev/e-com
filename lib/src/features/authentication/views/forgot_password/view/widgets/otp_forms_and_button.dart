import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../widgets/auth_input_field.dart';
import '../../controllers/otp_controller.dart';

class OtpFormsAndButton extends StatelessWidget {
  const OtpFormsAndButton({super.key, required this.isForSpinner});

  final bool isForSpinner;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    final otpController = OtpController.instance;
    //final forgetPasswordController = Get.put(ForgotPasswordController());

    return Form(
      key: otpController.otpKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthInputField(
            isDark: isDark,
            controller: otpController.otpCodeController,
            validator: (value) => AppValidator.validateOtp(value),
            hingText: AppLocalizations.of(context)!.otp,
            obscured: false,
            textInputType: TextInputType.number,
          ),
          const Gap(AppSizes.defaultSpace),
          Obx(
            () => Visibility(
              visible: otpController.startTime.value != 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.otpTimOne,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: AppColors.textPrimary),
                  ),
                  Obx(
                    () => Text(
                      " ${otpController.startTime.value.toString()} ",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: AppColors.primary),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.otpTimeTwo,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
              return Align(
                alignment: Alignment.centerLeft,
                child: AppButtons.textUnderlineButton(
                  onPressed: () {
                    if (otpController.startTime.value == 0) {
                      !isForSpinner
                          ? otpController.reSendCode()
                          : otpController.reSendCodeForSpinner();
                      otpController.timeCount();
                    }
                  },
                  buttonText: "Resend Code",
                  backgroundColor: otpController.startTime.value == 0
                      ? AppColors.primary
                      : AppColors.grey,
                ),
              );
            }
          ),
          const Gap(AppSizes.md),
          AppButtons.largeFlatFilledButton(
            onPressed: () {
              !isForSpinner
                  ? otpController.verify()
                  : otpController.verifyForSpinner();
            },
            buttonText: AppLocalizations.of(context)!.verify,
            backgroundColor: AppColors.secondary,
          ),
        ],
      ),
    );
  }
}
