import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../widgets/auth_input_field.dart';
import '../../controllers/new_password_controller.dart';

class NewPasswordFormsAndButton extends StatelessWidget {
  const NewPasswordFormsAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    final newPasswordController = NewPasswordController.instance;
    return Form(
      key: newPasswordController.newPasswordKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Password",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: AppSizes.fontSizeXSm,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Obx(
            () => AuthInputField(
              isDark: isDark,
              controller: newPasswordController.newPassword,
              validator: (value) => AppValidator.validatePassword(value),
              hingText: AppLocalizations.of(context)!.newPasswordHintText,
              obscured: newPasswordController.passwordObscured.value,
              suffixIcon: InkWell(
                onTap: () {
                  newPasswordController.passwordObscured.value =
                      !newPasswordController.passwordObscured.value;
                },
                child: Icon(newPasswordController.passwordObscured.value
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined),
              ),
            ),
          ),
          const Gap(AppSizes.spaceBtwInputFields),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Retype Password",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: AppSizes.fontSizeXSm,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Obx(
            () => AuthInputField(
              isDark: isDark,
              controller: newPasswordController.newConfirmPassword,
              validator: (value) => AppValidator.validateConfirmPassword(
                  newPasswordController.newConfirmPassword.text, newPasswordController.newPassword.text),
              hingText: AppLocalizations.of(context)!.confirmPasswordHintText,
              obscured: newPasswordController.confirmPasswordObscured.value,
              suffixIcon: InkWell(
                onTap: () {
                  newPasswordController.confirmPasswordObscured.value =
                      !newPasswordController.confirmPasswordObscured.value;
                },
                child: Icon(newPasswordController.confirmPasswordObscured.value
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined),
              ),
            ),
          ),
          const Gap(AppSizes.spaceBtwSections),
          AppButtons.largeFlatFilledButton(
              onPressed: () {
               newPasswordController.submit();
              },
              buttonText: AppLocalizations.of(context)!.submit,
          backgroundColor: AppColors.secondary,
          ),
        ],
      ),
    );
  }
}
