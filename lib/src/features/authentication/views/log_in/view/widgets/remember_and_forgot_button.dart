import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../controllers/login_controller.dart';

class RememberAndForgotButton extends StatelessWidget {
  const RememberAndForgotButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = LogInPageController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Row(
            children: [
              Checkbox(
                value: loginController.rememberMe.value,
                visualDensity: VisualDensity.compact,
                onChanged: (value) {
                  loginController.rememberMe.value = value!;
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              Text(
                AppLocalizations.of(context)!.rememberMe,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            // Get.to(const ForgotPassword());
          },
          child: Text(
            AppLocalizations.of(context)!.forgotPassword,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: AppColors.primary
            ),
          ),
        ),
      ],
    );
  }
}
