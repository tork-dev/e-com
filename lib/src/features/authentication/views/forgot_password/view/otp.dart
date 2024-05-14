import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../widgets/header_logo_part.dart';
import '../controllers/otp_controller.dart';
import 'widgets/otp_forms_and_button.dart';


class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OtpController());
    return AppLayoutWithBackButton(
      padding: AppSizes.defaultSpace,
        body: ListView(
          children: [
            const HeaderLogoPart(),
            const Gap(AppSizes.spaceBtwSections),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.verifyYourself,
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: AppColors.primary
              ),
            ),

            const Gap(AppSizes.sm),

            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.verifyYourselfSubtext,
              style: Theme.of(context).textTheme.titleMedium!.apply(
                  color: AppColors.darkGrey,
              ),
            ),

            const Gap(AppSizes.lg),
            const OtpFormsAndButton()
          ],
        ),
    );
  }
}