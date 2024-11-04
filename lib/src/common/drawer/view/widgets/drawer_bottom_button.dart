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
import 'common_drawer_card.dart';

class AppDrawerBottomButton extends StatelessWidget {
  const AppDrawerBottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(AppSizes.defaultSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AppBannerImage(
              imgBoarderRadius: 0,
                applyImageRadius: false,
                boarderRadius: 0,
                onPress: () {
                  AppDeviceUtils.browseUrl('https://www.facebook.com/jbeautybyKirei');
                },
                height: 32,
                imgUrl: AppImages.facebook),
            const Gap(AppSizes.defaultSpace),
            AppBannerImage(
                applyImageRadius: false,
                onPress: () {
                  AppDeviceUtils.browseUrl('https://www.youtube.com/channel/UCfcO3vgVRLyqcIoAl8AX8Ew');
                },
                height: 32,
                imgUrl: AppImages.youtube),
            const Gap(AppSizes.defaultSpace),
            AppBannerImage(
                applyImageRadius: false,
                onPress: () {
                  AppDeviceUtils.browseUrl('https://www.instagram.com/accounts/login/?next=%2Fjbeauty_kirei%2F');
                },
                height: 32,
                imgUrl: AppImages.instagram),
            const Gap(AppSizes.sm),
          ],
        ),
        const Gap(AppSizes.md),
        Text(
          "Version: ${AppLocalStorage().readData(LocalStorageKeys.appVersion)}",
          style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.white),
        )
      ],
    );
  }
}
