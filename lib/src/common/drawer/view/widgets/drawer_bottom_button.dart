import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/utils/constants/image_strings.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';

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
                    onPressed: () {},
                    backgroundColor: AppColors.secondary,
                    buttonRadius: 5,
                    verticallyPadding: 0,
                    buttonText: 'Login'),
              ),
              const Gap(AppSizes.sm),
              SizedBox(
                width: 100,
                child: AppButtons.largeFlatFilledButton(
                    onPressed: () {},
                    backgroundColor: AppColors.secondary,
                    buttonRadius: 5,
                    verticallyPadding: 0,
                    buttonText: 'Login'),
              ),
            ],
          ),
        ),
        const Gap(AppSizes.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBannerImage(
                onPress: () {},
                height: AppHelperFunctions.screenWidth() * 0.1,
                imgUrl: AppImages.facebook),
            const Gap(AppSizes.sm),
            AppBannerImage(
                onPress: () {},
                height: AppHelperFunctions.screenWidth() * 0.1,
                imgUrl: AppImages.youtube),
            const Gap(AppSizes.sm),
            AppBannerImage(
                onPress: () {},
                height: AppHelperFunctions.screenWidth() * 0.1,
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
