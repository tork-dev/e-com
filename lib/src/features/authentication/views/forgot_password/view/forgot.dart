import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/features/authentication/views/forgot_password/controllers/forgot_password_controllers.dart';
import 'package:torganic/src/features/authentication/views/widgets/header_logo_part.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../../../../common/styles/spacing_style.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import 'widgets/forgot_forms&button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotController = Get.put(ForgotPasswordController());
    return AppLayoutWithBackButton(
      padding: AppSizes.defaultSpace,
        body: ListView(
          shrinkWrap: true,
          children: [
            const HeaderLogoPart(),
            const Gap(AppSizes.spaceBtwSections),
            Text(
              AppLocalizations.of(context)!.forgotPassword,
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: AppColors.primary
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSizes.spaceBtwSections),
            const ForgotFormsAndButton()
          ],
        ),
    );
  }
}
