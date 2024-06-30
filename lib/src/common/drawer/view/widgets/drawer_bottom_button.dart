import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
import 'package:kirei/src/features/authentication/views/sign_up/view/signup.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/device/device_utility.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../widgets/buttons/app_buttons.dart';

class AppDrawerBottomButton extends StatelessWidget {
  const AppDrawerBottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: AppButtons.largeFlatFilledButton(
                    onPressed: () {
                      Get.to(()=> const LogIn());
                    },
                    backgroundColor: AppColors.secondary,
                    buttonRadius: 5,
                   // verticallyPadding: 0,
                    buttonText: 'Login'),
              ),
              const Gap(AppSizes.sm),
              SizedBox(
                width: 100,
                child: AppButtons.largeFlatFilledButton(
                    onPressed: () {
                      Get.to(()=> const SignUp());
                    },
                    backgroundColor: AppColors.secondary,
                    buttonRadius: 5,
                   // verticallyPadding: 0,
                    buttonText: 'Register'),
              ),
            ],
          ),
        ),
        const Gap(AppSizes.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBannerImage(
                onPress: () {
                  AppDeviceUtils.browseUrl('https://www.facebook.com/jbeautybyKirei');
                },
                height: 50,
                imgUrl: AppImages.facebook),
            const Gap(AppSizes.sm),
            AppBannerImage(
                onPress: () {
                  AppDeviceUtils.browseUrl('https://www.youtube.com/channel/UCfcO3vgVRLyqcIoAl8AX8Ew');
                },
                height: 50,
                imgUrl: AppImages.youtube),
            const Gap(AppSizes.sm),
            AppBannerImage(
                onPress: () {
                  AppDeviceUtils.browseUrl('https://www.instagram.com/accounts/login/?next=%2Fjbeauty_kirei%2F');
                },
                height: 50,
                imgUrl: AppImages.instagram),
            const Gap(AppSizes.sm),
          ],
        ),
        const Gap(AppSizes.md),
        Text(
          "version: ${AppLocalStorage().readData(LocalStorageKeys.appVersion)}",
          style: const TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
