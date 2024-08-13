import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/view/otp.dart';
import 'package:kirei/src/features/authentication/views/log_in/controllers/login_controller.dart';
import '../../../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../sign_up/view/signup.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: AppSizes.fontSizeSm,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
                      child: Icon(loginController.passwordObscured.value
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined),
                    ),
                    obscured: loginController.passwordObscured.value,
                  )
                ],
              ),
            ),
          ),
          const RememberAndForgotButton(),
          const Gap(AppSizes.spaceBtwSections),
          Obx(
            () => AppButtons.largeFlatFilledButton(
              onPressed: () => loginController.loginWithPassword.value
                  ? loginController.emailPasswordLogIn()
                  : loginController.sendCode(),
              buttonText: loginController.loginWithPassword.value
                  ? AppLocalizations.of(context)!.login
                  : AppLocalizations.of(context)!.sendOtp,
              backgroundColor: AppColors.darkGrey,
            ),
          ),
          const Gap(AppSizes.sm),
          Text(
            AppLocalizations.of(context)!.orLogInWith,
            textAlign: TextAlign.center,
          ),
          const Gap(AppSizes.sm),
          Obx(
            () => AppButtons.largeFlatFilledButton(
                onPressed: () {
                  loginController.loginWithPassword.value =
                      !loginController.loginWithPassword.value;
                },
                buttonText: loginController.loginWithPassword.value
                    ? AppLocalizations.of(context)!.loginWithOtp
                    : AppLocalizations.of(context)!.loginWithPassword,
                backgroundColor: loginController.loginWithPassword.value
                    ? AppColors.primary
                    : AppColors.signUpWithPassword),
          )
        ],
      ),
    );
  }
}
