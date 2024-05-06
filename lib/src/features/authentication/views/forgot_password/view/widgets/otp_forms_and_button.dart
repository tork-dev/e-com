import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../widgets/auth_input_field.dart';
import '../../controllers/otp_controller.dart';



class OtpFormsAndButton extends StatelessWidget {
  const OtpFormsAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    final otpController = OtpController.instance;
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
          ),
          const Gap(AppSizes.spaceBtwSections),
          AppButtons.largeFlatFilledButton(
              onPressed: () {
                otpController.verify();
              },
              buttonText: AppLocalizations.of(context)!.verify,
          backgroundColor: AppColors.secondary,
          ),
        ],
      ),
    );
  }
}
