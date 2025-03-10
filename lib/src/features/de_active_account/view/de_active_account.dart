import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/features/de_active_account/controller/de_active_controller.dart';
import 'package:kirei/src/features/de_active_account/view/widgets/de_active_widgets.dart';
import 'package:kirei/src/utils/constants/colors.dart';

class DeActiveAccount extends StatelessWidget {
  const DeActiveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeActiveController());
    return AppLayoutWithBackButton(
        title: Text(
          'Account Deletion and Data Retention',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: AppColors.primary),
        ),
        leadingIconColor: AppColors.darkGrey,
        body: DeActiveWidgets().accountDeletionTermsCondition()
    );
  }
}
