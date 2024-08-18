import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../../../common/layouts/layout_without_appbar/layout_without_appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../forgot_password/view/forgot.dart';
import '../../sign_up/view/signup.dart';
import '../../widgets/header_logo_part.dart';
import '../controllers/login_controller.dart';
import 'widgets/login_forms&button.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    String previousRoute = Get.parameters['prevRoute'] ?? '/home';
    final logInController = Get.put(LogInPageController(previousRoute: previousRoute));
    return PopScope(
      canPop: false,
      onPopInvoked: (pop) {
        Get.offAll(const HelloConvexAppBar(
          pageIndex: 0,
        ));
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: AppLayoutWithoutAppBar(
          body: Center(
            child: SizedBox(
              width: 400,
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  const HeaderLogoPart(),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: AppSizes.fontSizeLg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                  const Text(
                    "Phone",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: AppSizes.fontSizeSm,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const LogInFormsAndButton(),
                  const Gap(AppSizes.sm),
                  Obx(() {
                    return logInController.hittingApi.value
                        ? AppListViewLayout(
                            itemCount: 3,
                            builderFunction: (context, index) {
                              return ShimmerHelper()
                                  .buildBasicShimmer(height: 50);
                            })
                        : Column(
                            children: [
                              // const Gap(AppSizes.sm),
                              Visibility(
                                visible: AppLocalStorage().readData(LocalStorageKeys.facebookLogin),
                                child: AppButtons.largeFlatFilledIconButton(
                                    onPressed: () {
                                      logInController.onPressedFacebookLogin();
                                    },
                                    verticallyPadding: 14,
                                    backgroundColor: AppColors.facebookBg,
                                    imgUrl: AppImages.facebook,
                                    buttonName:
                                        'Login with facebook'.toUpperCase(),
                                    gapBetweenIconAndText: 12),
                              ),
                              const Gap(AppSizes.sm),
                              Visibility(
                                visible: AppLocalStorage().readData(LocalStorageKeys.googleLogin),
                                child: AppButtons.largeFlatFilledIconButton(
                                    onPressed: () {
                                      logInController.onPressedGoogleLogin();
                                    },
                                    verticallyPadding: 14,
                                    backgroundColor: AppColors.googleBg,
                                    imgUrl: AppImages.google,
                                    buttonName:
                                        'Login with google'.toUpperCase(),
                                    gapBetweenIconAndText: 5),
                              ),
                              const Gap(AppSizes.sm),
                              Visibility(
                                visible: !Platform.isAndroid &&
                                    AppLocalStorage().readData(LocalStorageKeys.appleLogin),
                                child: AppButtons.largeFlatFilledIconButton(
                                    onPressed: () {},
                                    verticallyPadding: 14,
                                    backgroundColor: AppColors.secondary,
                                    imgUrl: AppImages.appleLogo,
                                    buttonName:
                                        'Login with apple'.toUpperCase(),
                                    gapBetweenIconAndText: 12),
                              ),
                            ],
                          );
                  }),
                  const Gap(AppSizes.spaceBtwSections),
                  Center(
                      child: InkWell(
                          onTap: () {
                            Get.to(const SignUp());
                          },
                          child: Text(
                            AppLocalizations.of(context)!.dontHaveAccount,
                            style:
                                Theme.of(context).textTheme.titleMedium!.apply(
                                      decoration: TextDecoration.underline,
                                    ),
                          ))),
                  TextButton(
                    onPressed: () {
                      Get.to(const ForgotPassword());
                    },
                    child: Text(AppLocalizations.of(context)!.forgotPassword,
                        style: Theme.of(context).textTheme.bodySmall?.apply(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                            )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
