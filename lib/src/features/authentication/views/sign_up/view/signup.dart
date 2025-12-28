import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/authentication/views/log_in/controllers/login_controller.dart';
import '../../../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../../common/styles/skeleton_style.dart';
import '../../../../../common/widgets/buttons/app_buttons.dart';
import '../../../../../common/widgets/containers/card_container.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../../utils/local_storage/storage_utility.dart';
import '../../log_in/view/login.dart';
import '../controllers/signup_controller.dart';
import 'widgets/signup_forms_and_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpPageController());
    final logInController = LogInPageController.instance;
    return AppLayoutWithBackButton(
      title: Text("Signup"),
      padding: AppSizes.defaultSpace,
      showBackButton: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        child: Center(
          child: AppCardContainer(
            width: 400,
            borderRadius: AppSizes.borderRadiusMd,
            backgroundColor: AppColors.secondaryBackground,
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                const SignUpFormsAndButton(),
                const Gap(AppSizes.spaceBtwItems),
                // Obx(() {
                //   return logInController.hittingApi.value
                //       ? AppListViewLayout(
                //       itemCount: 3,
                //       builderFunction: (context, index) {
                //         return ShimmerHelper()
                //             .buildBasicShimmer(height: 50);
                //       })
                //       : Column(
                //     spacing: AppSizes.spaceBtwItems,
                //     children: [
                //       Visibility(
                //           visible: AppLocalStorage()
                //               .readData(LocalStorageKeys.googleLogin) == true,
                //           child: AppButtons.largeFlatOutlineButtonWithIcon(
                //             onPressed: () {
                //               logInController.onPressedFacebookLogin();
                //             },
                //             verticallyPadding: 14,
                //             imgUrl: AppImages.google,
                //             buttonText:
                //             'Signup with Google',
                //           )
                //       ),
                //       Visibility(
                //         visible: AppLocalStorage()
                //             .readData(LocalStorageKeys.facebookLogin) == true,
                //         child: AppButtons.largeFlatOutlineButtonWithIcon(
                //           onPressed: () {
                //             logInController.onPressedFacebookLogin();
                //           },
                //           verticallyPadding: 14,
                //           imgUrl: AppImages.facebook,
                //           buttonText:
                //           'Signup with Facebook',
                //         ),
                //       ),
                //       Visibility(
                //         visible: !Platform.isAndroid &&
                //             AppLocalStorage()
                //                 .readData(LocalStorageKeys.appleLogin) == true,
                //         child: AppButtons.largeFlatOutlineButtonWithIcon(
                //           onPressed: () {
                //             logInController.onPressedFacebookLogin();
                //           },
                //           verticallyPadding: 14,
                //           imgUrl: AppImages.appleLogo,
                //           buttonText:
                //           'Signup with Apple',
                //         ),
                //       ),
                //     ],
                //   );
                // }),
                Center(
                    child: InkWell(
                        onTap: () {
                          Get.to(const LogIn());
                        },
                        child: RichText(
                            text: TextSpan(text: AppLocalizations.of(context)!.alreadyHaveAccount,
                                style: Theme.of(context).textTheme.titleMedium,
                                children:[
                                  TextSpan(
                                      text: " ${AppLocalizations.of(context)!.login}",
                                      style: Theme.of(context).textTheme.titleLarge?.apply(
                                        color: AppColors.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.primary,
                                      ))
                                ]
                            )
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

