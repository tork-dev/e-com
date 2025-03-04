import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class OtherLogInOrSignUpOption extends StatelessWidget {
  final String title;
  final VoidCallback googleTap, facebookTap;

  const OtherLogInOrSignUpOption({super.key, required this.title, required this.googleTap, required this.facebookTap});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Divider(
              color: isDark ? AppColors.darkGrey : AppColors.grey,
              thickness: 0.5,
              indent: 60,
              endIndent: 5,
            )),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Flexible(
                child: Divider(
              color: isDark ? AppColors.darkGrey : AppColors.grey,
              thickness: 0.5,
              indent: 5,
              endIndent: 60,
            )),
          ],
        ),
        const Gap(AppSizes.spaceBtwDefaultItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButtons.smallIconButton(
                onIconPress: ()=> googleTap(), iconPath: AppImages.google),
            const Gap(AppSizes.spaceBtwDefaultItems),
            AppButtons.smallIconButton(
                onIconPress: ()=> facebookTap(), iconPath: AppImages.facebook)
          ],
        )
      ],
    );
  }
}
