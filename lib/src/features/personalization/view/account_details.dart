import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:kirei/src/features/personalization/controller/account_details_controller.dart';
import 'package:kirei/src/features/personalization/view/widget/edit_profile_text_fields.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'widget/edit_profile_picture_part.dart';


class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountDetailsController());
    final loginController = Get.put(LogInPageController());
    return AppLayoutWithBackButton(
        title: const Text('Edit Profile', style: TextStyle(color: AppColors.white),),
        leadingIconColor: AppColors.white,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        // bodyBackgroundColor: AppColors.secondaryBackground,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(AppSizes.defaultSpace),
              const AppEditProfilePicturePart(),
              const Gap(AppSizes.spaceBtwDefaultItems),
              AppDividersStyle.fullFlatAppDivider,
              const Gap(AppSizes.spaceBtwSections),
              const AppEditProfileTextFields()
            ],
          ),
        ));
  }
}

