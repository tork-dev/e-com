import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kirei/src/utils/device/device_utility.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../widgets/containers/card_container.dart';

class AppDrawerBottomButton extends StatelessWidget {
  const AppDrawerBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(AppSizes.defaultSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppCardContainer(
              onTap: () {
                AppDeviceUtils.browseUrl(
                  'https://www.facebook.com/jbeautybyKirei',
                );
              },
              height: 40,
              width: 40,
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.all(AppSizes.sm),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedFacebook02,
                color: AppColors.light,
              ),
            ),

            const Gap(AppSizes.defaultSpace),
            AppCardContainer(
              onTap: () {
                AppDeviceUtils.browseUrl(
                  'https://www.youtube.com/channel/UCfcO3vgVRLyqcIoAl8AX8Ew',
                );
              },
              height: 40,
              width: 40,
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.all(AppSizes.sm),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedYoutube,
                color: AppColors.light,
              ),
            ),
            const Gap(AppSizes.defaultSpace),

            AppCardContainer(
              onTap: () {
                AppDeviceUtils.browseUrl(
                  'https://www.instagram.com/accounts/login/?next=%2Fjbeauty_kirei%2F',
                );
              },
              height: 40,
              width: 40,
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.all(AppSizes.sm),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedInstagram,
                color: AppColors.light,
              ),
            ),
            const Gap(AppSizes.sm),
          ],
        ),
        const Gap(AppSizes.md),
        Text(
          "Version: ${AppLocalStorage().readData(LocalStorageKeys.appVersion)}",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
