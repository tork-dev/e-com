import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:kirei/src/features/personalization/controller/account_details_controller.dart';
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
      child: Obx( () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gap(AppSizes.xs),
              AuthInputField(
                hingText: 'Enter your Name',
                controller: accountDetailsController.nameController,
                obscured: false,
                validator: null,
              ),
              const Gap(AppSizes.spaceBtwInputFields),
              Text(
                'Phone',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gap(AppSizes.xs),
              AuthInputField(
                hingText: 'Enter your Phone',
                controller: accountDetailsController.phoneNumberController,
                obscured: false,
                validator: null,
                enableTextField: false,
              ),
              Visibility(
                visible: AppLocalStorage().readData(LocalStorageKeys.userHavePassword),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(AppSizes.spaceBtwInputFields),
                    Text(
                      'Current Password',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Gap(AppSizes.xs),
                    AuthInputField(
                      hingText: 'Enter your password',
                      controller:
                          accountDetailsController.currentPasswordController,
                      obscured: accountDetailsController.visibleCurrentPassword.value,
                      validator: null,
                      suffixIcon: InkWell(
                        onTap: () {
                          accountDetailsController.visibleCurrentPassword.value =
                          !accountDetailsController.visibleCurrentPassword.value;
                        },
                        child: Icon(accountDetailsController.visibleCurrentPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(AppSizes.spaceBtwInputFields),
              Text(
                'New Password',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gap(AppSizes.xs),
              AuthInputField(
                hingText: 'Enter new password',
                controller: accountDetailsController.newPasswordController,
                obscured: accountDetailsController.visibleNewPassword.value,
                validator: (value) => AppValidator.validatePassword(value),
                suffixIcon: InkWell(
                  onTap: () {
                    accountDetailsController.visibleNewPassword.value =
                    !accountDetailsController.visibleNewPassword.value;
                  },
                  child: Icon(accountDetailsController.visibleNewPassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility),
                ),
              ),
              const Gap(AppSizes.spaceBtwInputFields),
              Text(
                'Confirm New Password',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gap(AppSizes.xs),
              AuthInputField(
                hingText: 'Enter confirm password',
                controller: accountDetailsController.confirmNewPasswordController,
                obscured: accountDetailsController.visibleConfirmPassword.value,
                validator: (value) => AppValidator.validateConfirmPassword(
                    value, accountDetailsController.newPasswordController.text),
                suffixIcon: InkWell(
                  onTap: () {
                    accountDetailsController.visibleConfirmPassword.value =
                    !accountDetailsController.visibleConfirmPassword.value;
                  },
                  child: Icon(accountDetailsController.visibleConfirmPassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility),
                ),
              ),
              const Gap(AppSizes.spaceBtwInputFields),
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
          );
        }
      ),
    );
  }
}
