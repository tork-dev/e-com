import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/authentication/views/widgets/header_logo_part.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../sign_up/view/signup.dart';
import '../../sign_up/view/widgets/signup_forms_and_button.dart';
import '../controllers/login_controller.dart';
import 'widgets/login_forms&button.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final logInController =
        Get.put(LogInPageController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AppLayoutWithBackButton(
        backToHome: true,
        bodyBackgroundColor: AppColors.white,
        customLeadingIcon: Icons.arrow_back_ios_new_rounded,
        showCustomLeading: false,
        showBackButton: true,
        leadingOnPress: () {
          Get.offAllNamed('/home');
        },
        body: Center(
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderLogoPart(),
              Gap(AppSizes.spaceBtwSections),
              AppCardContainer(
                width: 400,
                height: 550,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.secondaryBackground,
                padding: EdgeInsets.all(AppSizes.defaultSpace),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                  spacing: AppSizes.defaultSpace,
                  children: [
                    TabBar(
                      indicatorColor: AppColors.primary,
                      labelColor: AppColors.primary,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: Theme.of(context).textTheme.titleSmall,
                      tabs: const [
                        Tab(text: 'Login'),
                        Tab(text: 'Register'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            const LogInFormsAndButton(),
                            const Gap(AppSizes.spaceBtwItems),
                            Obx(() {
                              return logInController.hittingApi.value
                                  ? AppListViewLayout(
                                      itemCount: 3,
                                      builderFunction: (context, index) {
                                        return ShimmerHelper()
                                            .buildBasicShimmer(height: 50);
                                      })
                                  : Column(
                                spacing: AppSizes.spaceBtwItems,
                                      children: [
                                        Visibility(
                                            visible: AppLocalStorage()
                                                .readData(LocalStorageKeys.googleLogin) == true,
                                            child: AppButtons.largeFlatOutlineButtonWithIcon(
                                              onPressed: () {
                                                logInController.onPressedGoogleLogin();
                                              },
                                              verticallyPadding: 14,
                                              imgUrl: AppImages.google,
                                              buttonText:
                                              'Login with Google',
                                            )
                                        ),
                                        Visibility(
                                          visible: AppLocalStorage()
                                              .readData(LocalStorageKeys.facebookLogin) == true,
                                          child: AppButtons.largeFlatOutlineButtonWithIcon(
                                              onPressed: () {
                                                logInController.onPressedFacebookLogin();
                                              },
                                              verticallyPadding: 14,
                                              imgUrl: AppImages.facebook,
                                              buttonText:
                                                  'Login with Facebook',
                                          ),
                                        ),
                                        Visibility(
                                          visible: !Platform.isAndroid &&
                                              AppLocalStorage()
                                                  .readData(LocalStorageKeys.appleLogin) == true,
                                          child: AppButtons.largeFlatOutlineButtonWithIcon(
                                            onPressed: () {
                                              logInController.onPressAppleLogin();
                                            },
                                            verticallyPadding: 14,
                                            imgUrl: AppImages.appleLogo,
                                            buttonText:
                                            'Login with Apple',
                                          ),
                                        ),
                                      ],
                                    );
                            }),
                            Gap(AppSizes.sm),
                            Center(
                                child: Builder(
                                  builder: (context) {
                                    return InkWell(
                                        onTap: () {
                                          // Get.to(const SignUp());
                                          DefaultTabController.of(context).animateTo(1);
                                        },
                                        child: RichText(
                                          text: TextSpan(text: AppLocalizations.of(context)!.dontHaveAccount,
                                          style: Theme.of(context).textTheme.titleMedium,
                                          children:[
                                            TextSpan(
                                              text: " ${AppLocalizations.of(context)!.signUp}",
                                              style: Theme.of(context).textTheme.titleLarge?.apply(
                                                color: AppColors.primary,
                                                decoration: TextDecoration.underline,
                                                decorationColor: AppColors.primary,
                                            ))
                                          ]
                                          )
                                        ));
                                  }
                                )),
                            const Gap(AppSizes.spaceBtwSections),
                          ],
                        ),
                          ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              const SignUpFormsAndButton(),
                              const Gap(AppSizes.spaceBtwItems),
                              Obx(() {
                                return logInController.hittingApi.value
                                    ? AppListViewLayout(
                                    itemCount: 3,
                                    builderFunction: (context, index) {
                                      return ShimmerHelper()
                                          .buildBasicShimmer(height: 50);
                                    })
                                    : Column(
                                  spacing: AppSizes.spaceBtwItems,
                                  children: [
                                    Visibility(
                                        visible: AppLocalStorage()
                                            .readData(LocalStorageKeys.googleLogin) == true,
                                        child: AppButtons.largeFlatOutlineButtonWithIcon(
                                          onPressed: () {
                                            logInController.onPressedFacebookLogin();
                                          },
                                          verticallyPadding: 14,
                                          imgUrl: AppImages.google,
                                          buttonText:
                                          'Signup with Google',
                                        )
                                    ),
                                    Visibility(
                                      visible: AppLocalStorage()
                                          .readData(LocalStorageKeys.facebookLogin) == true,
                                      child: AppButtons.largeFlatOutlineButtonWithIcon(
                                        onPressed: () {
                                          logInController.onPressedFacebookLogin();
                                        },
                                        verticallyPadding: 14,
                                        imgUrl: AppImages.facebook,
                                        buttonText:
                                        'Signup with Facebook',
                                      ),
                                    ),
                                    Visibility(
                                      visible: !Platform.isAndroid &&
                                          AppLocalStorage()
                                              .readData(LocalStorageKeys.appleLogin) == true,
                                      child: AppButtons.largeFlatOutlineButtonWithIcon(
                                        onPressed: () {
                                          logInController.onPressedFacebookLogin();
                                        },
                                        verticallyPadding: 14,
                                        imgUrl: AppImages.appleLogo,
                                        buttonText:
                                        'Signup with Apple',
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              Center(
                                  child: Builder(
                                    builder: (context) {
                                      return InkWell(
                                          onTap: () {
                                            DefaultTabController.of(context).animateTo(0);
                                            // Get.to(const LogIn());
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
                                          ));
                                    }
                                  )),
                              const Gap(AppSizes.spaceBtwSections),
                            ],
                          ),
                      ]
                      ),)
                  ],
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
