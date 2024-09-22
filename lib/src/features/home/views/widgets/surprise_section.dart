import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kirei/src/features/authentication/views/widgets/auth_input_field.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/validators/validation.dart';

class HomeSurpriseSection extends StatelessWidget {
  const HomeSurpriseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    return Obx(() {
      return Visibility(
        visible: homeController.hittingApi.value
            ? true
            : homeController.homeProductResponse.value.homepageSettings
                    ?.surprizeGift?.isActive ==
                "1",
        child: Column(
          children: [
            const Gap(AppSizes.spaceBtwSections),
            Form(
              key: homeController.surprisePhoneKey,
              child: SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    const AppBannerImage(
                      width: double.infinity,
                      applyImageRadius: false,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      isNetworkImage: false,
                      imgUrl: AppImages.surprisingSectionBg,
                    ),
                    Center(
                        child: AppCardContainer(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            applyRadius: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  homeController.homeProductResponse.value
                                          .homepageSettings?.surprizeGift?.title ??
                                      'Get surprise gift',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .apply(color: AppColors.white),
                                ),
                                const Gap(AppSizes.sm),
                                HtmlWidget(
                                  homeController
                                          .homeProductResponse
                                          .value
                                          .homepageSettings
                                          ?.surprizeGift!
                                          .description ??
                                      '',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(color: AppColors.white),
                                ),
                                const Gap(AppSizes.spaceBtwSections),
                                TextFormField(
                                  controller: homeController.surprisePhoneController,
                                  cursorColor: AppColors.primary,
                                  validator: (value) =>
                                      AppValidator.validatePhoneNumber(value),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    errorStyle: TextStyle(color: AppColors.white, ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: AppSizes.md,
                                        vertical: AppSizes.spaceBtwDefaultItems),
                                    hintText: '01*********',
                                    fillColor: AppColors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(width: 0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(width: 0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(width: 0)),
                                  ),
                                ),
                                const Gap(AppSizes.spaceBtwDefaultItems),
                                AppButtons.largeFlatFilledButton(
                                    onPressed: () {

                                      homeController.getSurpriseTap();
                                    },
                                    backgroundColor: AppColors.secondary,
                                    buttonText: 'Submit')
                              ],
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
