import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../controllers/signup_controller.dart';
import 'widgets/signup_forms_and_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpPageController());
    return const AppLayoutWithBackButton(
      padding: AppSizes.defaultSpace,
      showBackButton: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(AppImages.lightAppLogo),
              width: 150,
            ),
            Gap(AppSizes.spaceBtwSmallItem),
            Text("Register",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: AppSizes.fontSizeLg,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(AppSizes.spaceBtwSections),
           // const Align(
           //    alignment: Alignment.centerLeft,
           //    child: Text("Phone",
           //      style: TextStyle(
           //        color: AppColors.primary,
           //        fontSize: AppSizes.fontSizeSm,
           //        fontWeight: FontWeight.w500,
           //      ),
           //    ),
           //  ),
            //const Gap(AppSizes.spaceBtwRowItem),
            SignUpFormsAndButton(),
            Gap(AppSizes.spaceBtwSections),
            // OtherLogInOrSignUpOption(
            //   title: AppLocalizations.of(context)!.orSignUpWith,
            //   googleTap: () {},
            //   facebookTap: () {},
            // )
          ],
        ),
      ),
    );
  }
}
