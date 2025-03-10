import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../controllers/login_controller.dart';

class RememberAndForgotButton extends StatelessWidget {
  const RememberAndForgotButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = LogInPageController.instance;
    return Row(children: [
      Expanded(
        child: Row(
          children: [
            Obx(
              () => Checkbox(
                value: loginController.rememberMe.value,
                onChanged: (value) {
                  loginController.rememberMe.value =
                      !loginController.rememberMe.value;
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Text(AppLocalizations.of(context)!.rememberMe,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    //.apply(color: isDark ? AppColors.light : AppColors.dark),
                    .apply(color: AppColors.primary),
            )
          ],
        ),
      ),
      // TextButton(
      //   onPressed: () {
      //     Get.to(const ForgotPassword());
      //   },
      //   child: Text(AppLocalizations.of(context)!.forgotPassword,
      //       style: Theme.of(context).textTheme.bodySmall?.apply(color: AppColors.primary)),
      // )
    ]);
  }
}
