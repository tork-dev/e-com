import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../widgets/other_login_option.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../controllers/signup_controller.dart';
import 'widgets/signup_forms_and_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpPageController());
    return AppLayoutWithBackButton(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(AppImages.darkAppLogo1),
            width: 100,
          ),
          const Gap(AppSizes.spaceBtwSections),
          const SignUpFormsAndButton(),
          const Gap(AppSizes.spaceBtwSections),
          OtherLogInOrSignUpOption(
            title: AppLocalizations.of(context)!.orSignUpWith,
            googleTap: () {},
            facebookTap: () {},
          )
        ],
      ),
    );
  }
}
