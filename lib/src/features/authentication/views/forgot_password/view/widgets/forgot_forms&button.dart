import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../widgets/auth_input_field.dart';
import '../../controllers/forgot_password_controllers.dart';
import '../otp.dart';



class ForgotFormsAndButton extends StatelessWidget {
  const ForgotFormsAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    final forgotController = ForgotPasswordController.instance;
    return Form(
      key: forgotController.forgotEmailKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            controller: forgotController.forgotPasswordEmail,
            hingText: AppLocalizations.of(context)!.emailOrPhoneHintText,
            obscured: false,
            validator: (value)=> AppValidator.validateEmailOrPhone(value),
          ),

          const Gap(AppSizes.spaceBtwSections),
          AppButtons.largeFlatFilledButton(
              onPressed: () {
                forgotController.sendCode();
              },
              buttonText: AppLocalizations.of(context)!.sendCode,
          bcColor: AppColors.secondary
          ),
        ],
      ),
    );
  }
}
