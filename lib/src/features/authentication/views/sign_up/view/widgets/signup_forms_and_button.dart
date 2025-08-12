import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/authentication/views/widgets/other_login_option.dart';
import '../../../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../log_in/view/login.dart';
import '../../../widgets/auth_input_field.dart';
import '../../controllers/signup_controller.dart';

class SignUpFormsAndButton extends StatelessWidget {
  const SignUpFormsAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpPageController());
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Form(
      key: signUpController.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(
            () => Visibility(
              visible: signUpController.signupWithPassword.value,
              child: Column(
                spacing: AppSizes.xs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full Name",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AuthInputField(
                    isDark: isDark,
                    controller: signUpController.nameController,
                    validator: (value) => null,
                    hingText: AppLocalizations.of(context)!.nameHintText,
                    obscured: false,
                  ),
                ],
              ),
            ),
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          Text("Phone", style: Theme.of(context).textTheme.titleMedium),
          Gap(AppSizes.xs),
          AuthInputField(
            isDark: isDark,
            controller: signUpController.emailController,
            validator: (value) => AppValidator.validateEmailOrPhone(value),
            hingText: AppLocalizations.of(context)!.emailOrPhoneHintText,
            obscured: false,
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          Obx(
            () => Visibility(
              visible: signUpController.signupWithPassword.value,
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
                    controller: signUpController.passwordController,
                    validator: (value) => AppValidator.validatePassword(value),
                    hingText: AppLocalizations.of(context)!.passwordHintText,
                    suffixIcon: InkWell(
                      onTap: () {
                        signUpController.passwordObscured.value =
                            !signUpController.passwordObscured.value;
                      },
                      child: Icon(
                        signUpController.passwordObscured.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        color: AppColors.grey,
                      ),
                    ),
                    obscured: signUpController.passwordObscured.value,
                  ),
                  const Gap(AppSizes.spaceBtwInputFields),
                  Text(
                    "Confirm Password",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Gap(AppSizes.xs),
                  AuthInputField(
                    isDark: isDark,
                    controller: signUpController.confirmPasswordController,
                    validator:
                        (value) => AppValidator.validateConfirmPassword(
                          signUpController.confirmPasswordController.text,
                          signUpController.passwordController.text,
                        ),
                    hingText:
                        AppLocalizations.of(context)!.confirmPasswordHintText,
                    suffixIcon: InkWell(
                      onTap: () {
                        signUpController.confirmPasswordObscured.value =
                            !signUpController.confirmPasswordObscured.value;
                      },
                      child: Icon(
                        signUpController.confirmPasswordObscured.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        color: AppColors.grey,
                      ),
                    ),
                    obscured: signUpController.confirmPasswordObscured.value,
                  ),
                  const Gap(AppSizes.spaceBtwItems),
                ],
              ),
            ),
          ),
          Obx(
            () => AppButtons.largeFlatFilledButton(
              onPressed: () {
                signUpController.signupWithPassword.value
                    ? signUpController.emailPasswordSignUp()
                    : signUpController.sendOtpSignUp();
              },
              buttonText:
                  signUpController.signupWithPassword.value
                      ? AppLocalizations.of(context)!.signUp
                      : AppLocalizations.of(context)!.sendOtp,
            ),
          ),
          const Gap(AppSizes.spaceBtwItems),
          OtherLogInOrSignUpOption(title: "Or Register With"),
          Obx(
            () => AppButtons.largeFlatFilledButton(
              onPressed: () {
                // Get.offAll(const LogIn());
                signUpController.signupWithPassword.value =
                    !signUpController.signupWithPassword.value;
              },
              backgroundColor: AppColors.buttonSecondary,
              buttonText:
                  signUpController.signupWithPassword.value
                      ? AppLocalizations.of(context)!.signupWithOtp
                      : AppLocalizations.of(context)!.signupWithPassword,
            ),
          ),
        ],
      ),
    );
  }
}
