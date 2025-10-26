import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class OtherLogInOrSignUpOption extends StatelessWidget {
  final String title;
  // final VoidCallback googleTap, facebookTap;

  const OtherLogInOrSignUpOption(
      {super.key,
        required this.title,
        // required this.googleTap,
        // required this.facebookTap
      });

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
              child: AppDividersStyle.appDivider(),
            ),
            Gap(AppHelperFunctions.screenHeight() * 0.02),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium!.apply(
                color: !isDark? AppColors.darkGrey : AppColors.light,
              ),
            ),
            const Gap(AppSizes.spaceBtwSmallItem),
            Flexible(
              child: AppDividersStyle.appDivider(),
            ),
          ],
        ),
        const Gap(AppSizes.spaceBtwItems),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     // Obx(() {
        //     //   return SizedBox(
        //     //     height: 52,
        //     //     child: AppButtons.largeFlatFilledButton(
        //     //       onPressed: () {
        //     //         loginController.loginWithPassword.value = !loginController.loginWithPassword.value;
        //     //       },
        //     //       buttonText: !loginController.loginWithPassword.value
        //     //           ? AppLocalizations.of(context)!.loginWithPassword
        //     //           : AppLocalizations.of(context)!.loginWithOtp,
        //     //       isPadding: true,
        //     //       borderRediousSize: 34,
        //     //       isBorderRadiousSize: true,
        //     //       fontWeight: FontWeight.w600,
        //     //       color: !isDark? AppColors.secondary : AppColors.containerColorDark,
        //     //       buttonTextColor: AppColors.buttonTextColor,
        //     //       fontSizes: 14,
        //     //     ),
        //     //   );
        //     // }
        //     // ),
        //     const Gap(AppSizes.sm),
        //     // SizedBox(
        //     //   height: 52,
        //     //   child: AppButtons.largeFlatOutlineWithImageButton(
        //     //     onPressed: () => googleTap(),
        //     //     //buttonText: "Continue with google",
        //     //     buttonText: AppLocalizations.of(context)!.continueGoogle,
        //     //     iconPath: AppImages.google,
        //     //     isBorderRadiousSize: true,
        //     //     borderRediousSize: 32,
        //     //     buttonTextColor: AppColors.textPrimary,
        //     //   ),
        //     // ),
        //
        //     const Gap(AppSizes.sm),
        //
        //     // AppButtons.smallIconButton(
        //     //     onIconPress: ()=> facebookTap(), iconPath: AppImages.facebook),
        //
        //     // SizedBox(
        //     //   height: 52,
        //     //   child: AppButtons.largeFlatOutlineWithImageButton(
        //     //     onPressed: () => facebookTap(),
        //     //     //buttonText: "Continue with faceboobk",
        //     //     buttonText: AppLocalizations.of(context)!.continueFacebook,
        //     //     iconPath: AppImages.facebook,
        //     //     isBorderRadiousSize: true,
        //     //     borderRediousSize: 32,
        //     //     buttonTextColor: AppColors.textPrimary,
        //     //   ),
        //     // ),
        //   ],
        // )
      ],
    );
  }
}
