import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
    final signUpController = SignUpPageController.instance;
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Form(
      key: signUpController.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Visibility(
            visible: signUpController.signupWithPassword.value,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Name",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: AppSizes.fontSizeSm,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                AuthInputField(
                  isDark: isDark,
                  controller: signUpController.nameController,
                  validator: (value) => null,
                  hingText: "Your Name",
                  obscured: false,
                ),
              ],
            ),),),

          const Gap(AppSizes.spaceBtwSmallItem),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Phone",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: AppSizes.fontSizeSm,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          AuthInputField(
            isDark: isDark,
            controller: signUpController.emailController,
            validator: (value) => AppValidator.validateEmailOrPhone(value),
            hingText: AppLocalizations.of(context)!.emailOrPhoneHintText,
            obscured: false,
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          Obx(() => Visibility(
              visible: signUpController.signupWithPassword.value,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: AppSizes.fontSizeSm,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
                      child: Icon(signUpController.passwordObscured.value
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined),
                    ),
                    obscured: signUpController.passwordObscured.value,
                  ),
                  const Gap(AppSizes.spaceBtwInputFields),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Retype Password",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: AppSizes.fontSizeSm,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AuthInputField(
                    isDark: isDark,
                    controller: signUpController.confirmPasswordController,
                    validator: (value) => AppValidator.validateConfirmPassword(
                        signUpController.confirmPasswordController.text, signUpController.passwordController.text),
                    hingText: AppLocalizations.of(context)!.confirmPasswordHintText,
                    suffixIcon: InkWell(
                      onTap: () {
                        signUpController.confirmPasswordObscured.value =
                        !signUpController.confirmPasswordObscured.value;
                      },
                      child: Icon(signUpController.confirmPasswordObscured.value
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined),
                    ),
                    obscured: signUpController.confirmPasswordObscured.value,
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                ],
              ))),
          Obx(() => AppButtons.largeFlatFilledButton(
            onPressed: () {
              signUpController.signupWithPassword.value ? signUpController.emailPasswordSignUp() : signUpController.sendOtpSignUp();
            },
            buttonText: signUpController.signupWithPassword.value ? AppLocalizations.of(context)!.signUp : AppLocalizations.of(context)!.sendOtp,
            backgroundColor: AppColors.secondary,
          )),
          const Gap(AppSizes.sm),
           Text(AppLocalizations.of(context)!.orSignUpWith,
             style: TextStyle(
               color: AppColors.darkGrey,
               fontSize: AppSizes.fontSizeSm,
               fontWeight: FontWeight.w500,
             ),
           ),
          const Gap(AppSizes.sm),
          Obx(() => AppButtons.largeFlatFilledButton(
            onPressed: () {
              // Get.offAll(const LogIn());
              signUpController.signupWithPassword.value = ! signUpController.signupWithPassword.value ;
            },
            //buttonText: "Register"
            buttonText: signUpController.signupWithPassword.value ? AppLocalizations.of(context)!.signupWithOtp : AppLocalizations.of(context)!.signupWithPassword,
          ),),

          const Gap(AppSizes.lg),

          GestureDetector(
            onTap: (){
              Get.offAll(const LogIn());
            },
            child: const Text("Login Now !",
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: AppSizes.fontSizeLg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


