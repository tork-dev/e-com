import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:kirei/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:kirei/src/features/authentication/views/widgets/other_login_option.dart';
import '../../../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../widgets/auth_input_field.dart';
import 'remember_and_forgot_button.dart';

class LogInFormsAndButton extends StatelessWidget {
  const LogInFormsAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = LogInPageController.instance;
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Form(
      key: loginController.logInFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Phone", style: Theme.of(context).textTheme.titleMedium),
          Gap(AppSizes.xs),
          AuthInputField(
            isDark: isDark,
            controller: loginController.emailController,
            validator: (value) => AppValidator.validateEmailOrPhone(value),
            hingText: AppLocalizations.of(context)!.emailOrPhoneHintText,
            obscured: false,
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          Obx(
            () => Visibility(
              visible: loginController.loginWithPassword.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Gap(AppSizes.xs),
                  AuthInputField(
                    isDark: isDark,
                    controller: loginController.passwordController,
                    validator: (value) => AppValidator.validatePassword(value),
                    hingText: AppLocalizations.of(context)!.passwordHintText,
                    suffixIcon: InkWell(
                      onTap: () {
                        loginController.passwordObscured.value =
                            !loginController.passwordObscured.value;
                      },
                      child: Icon(
                        loginController.passwordObscured.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        color: AppColors.grey,
                      ),
                    ),
                    obscured: loginController.passwordObscured.value,
                  ),
                  const Gap(AppSizes.spaceBtwSmallItem),
                  const RememberAndForgotButton(),
                  const Gap(AppSizes.spaceBtwItems),
                ],
              ),
            ),
          ),
          Obx(
            () => AppButtons.largeFlatFilledButton(
              onPressed:
                  () =>
                      loginController.loginWithPassword.value
                          ? loginController.emailPasswordLogIn()
                          : loginController.sendCode(),
              buttonText:
                  loginController.loginWithPassword.value
                      ? AppLocalizations.of(context)!.login
                      : AppLocalizations.of(context)!.sendOtp,
              backgroundColor: AppColors.primary,
            ),
          ),
          const Gap(AppSizes.spaceBtwSections),
          OtherLogInOrSignUpOption(title: "Or Login With",),
          const Gap(AppSizes.sm),
          Obx(
            () => AppButtons.largeFlatFilledButton(
              onPressed: () {
                loginController.loginWithPassword.value =
                    !loginController.loginWithPassword.value;
              },
              buttonText:
                  loginController.loginWithPassword.value
                      ? AppLocalizations.of(context)!.loginWithOtp
                      : AppLocalizations.of(context)!.loginWithPassword,
              backgroundColor: AppColors.buttonSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
