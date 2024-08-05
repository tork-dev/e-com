import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/personalization/controller/account_details_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/helpers/auth_helper.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:kirei/src/utils/validators/validation.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../authentication/views/widgets/auth_input_field.dart';

class AppEditProfileTextFields extends StatelessWidget {
  const AppEditProfileTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    final accountDetailsController = AccountDetailsController.instance;
    final loginController = LogInPageController.instance;
    return Form(
      key: accountDetailsController.updatePasswordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: AppColors.primary),
          ),
          AuthInputField(
            hingText: 'Name',
            controller: accountDetailsController.nameController,
            obscured: false,
            validator: null,
          ),
          Visibility(
            visible: AppLocalStorage().readData(LocalStorageKeys.userHavePassword),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(AppSizes.spaceBtwItems),
                Text(
                  'Current Password',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: AppColors.primary),
                ),
                AuthInputField(
                  hingText: '******',
                  controller:
                      accountDetailsController.currentPasswordController,
                  obscured: true,
                  validator: null,
                ),
              ],
            ),
          ),
          const Gap(AppSizes.spaceBtwItems),
          Text(
            'New Password',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: AppColors.primary),
          ),
          AuthInputField(
            hingText: '******',
            controller: accountDetailsController.newPasswordController,
            obscured: true,
            validator: (value) => AppValidator.validatePassword(value),
          ),
          const Gap(AppSizes.spaceBtwItems),
          Text(
            'Confirm New Password',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: AppColors.primary),
          ),
          AuthInputField(
            hingText: '******',
            controller: accountDetailsController.confirmNewPasswordController,
            obscured: true,
            validator: (value) => AppValidator.validateConfirmPassword(
                value, accountDetailsController.newPasswordController.text),
          ),
          const Gap(AppSizes.spaceBtwItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 150,
                child: AppButtons.largeFlatFilledButton(
                    onPressed: () {
                      accountDetailsController.profileUpdate().then((value) =>
                          loginController.getUserDataByToken().then((value) =>
                              AuthHelper().saveUserDataByToken(
                                  loginController.userDataByToken.value)));
                    },
                    buttonText: 'Update'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
