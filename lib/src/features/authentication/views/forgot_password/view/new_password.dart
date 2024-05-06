import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../widgets/header_logo_part.dart';
import '../controllers/new_password_controller.dart';
import 'widgets/new_password_forms&button.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final newPasswordController = Get.put(NewPasswordController());
    return AppLayoutWithBackButton(
        body: ListView(
          children: [
            const HeaderLogoPart(),
            const Gap(AppSizes.spaceBtwSections),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.newPassword,
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: AppColors.primary
              ),
            ),
            const Gap(AppSizes.spaceBtwSections),
            const NewPasswordFormsAndButton()
          ],
        ),
    );
  }
}
