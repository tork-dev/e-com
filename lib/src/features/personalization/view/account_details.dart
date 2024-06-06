import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/authentication/views/log_in/controllers/login_controller.dart';
import 'package:torganic/src/features/authentication/views/widgets/auth_input_field.dart';
import 'package:torganic/src/features/bottom_navigation/convex_controller.dart';
import 'package:torganic/src/features/personalization/controller/account_details_controller.dart';
import 'package:torganic/src/features/personalization/view/widget/edit_profile_text_fields.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import 'widget/edit_profile_picture_part.dart';


class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountDetailsController());
    final loginController = Get.put(LogInPageController());
    return AppLayoutWithBackButton(
      padding: AppSizes.defaultSpace,
        title: const Text('Edit Profile', style: TextStyle(color: AppColors.white),),
        leadingIconColor: AppColors.white,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(AppSizes.defaultSpace),
              const AppEditProfilePicturePart(),
              const Gap(AppSizes.spaceBtwItems),
              AppDividersStyle.fullFlatAppDivider,
              const Gap(AppSizes.spaceBtwSections),
              const AppEditProfileTextFields()
            ],
          ),
        ));
  }
}

