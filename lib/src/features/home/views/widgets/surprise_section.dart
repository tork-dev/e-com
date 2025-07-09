import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/features/home/controller/home_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/validators/validation.dart';

class HomeSurpriseSection extends StatelessWidget {
  const HomeSurpriseSection({super.key, required this.imageUrl, required this.title, required this.description, required this.buttonName, required this.largeButton, required this.onPressed, this.controller, required this.visibleSection, required this.visibleInputField});

  final String imageUrl, title, description, buttonName;
  final bool largeButton, visibleSection, visibleInputField;
  final VoidCallback onPressed;
  final TextEditingController? controller;
  final Color backgroundColor = AppColors.contentInversePrimary;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visibleSection,
        child: AppCardContainer(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.defaultSpace,
            horizontal: AppHelperFunctions.screenWidth() * .1,
          ),
          margin: EdgeInsets.symmetric(horizontal: AppSizes.md),
          backgroundColor: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBannerImage(
                width: AppHelperFunctions.screenWidth() * .7,
                isNetworkImage: true,
                imgUrl: imageUrl
              ),
              Gap(AppSizes.spaceBtwItems),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium!,
                ),
              ),
              const Gap(AppSizes.sm),
              Align(
                alignment: Alignment.centerRight,
                child: HtmlWidget(
                   description,
                  textStyle: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Visibility(
                visible: visibleInputField,
                child: Column(
                  children: [
                    const Gap(AppSizes.spaceBtwItems),
                    TextFormField(
                      controller: controller,
                      cursorColor: AppColors.primary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      validator: (value) => AppValidator.validatePhoneNumber(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(color: AppColors.white),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.md,
                          vertical: AppSizes.spaceBtwDefaultItems,
                        ),
                        hintText: '01*********',
                        fillColor: AppColors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusMd,
                          ),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusMd,
                          ),
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusMd,
                          ),
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(AppSizes.spaceBtwItems),
              largeButton?
              AppButtons.largeFlatFilledButton(
                onPressed: () => onPressed(),
                backgroundColor: AppColors.secondary,
                buttonText: buttonName,
              ):
              Align(
                alignment: Alignment.centerLeft,
                child: AppButtons.wrapButton(
                  onPressed: () => onPressed(),
                  backgroundColor: AppColors.secondary,
                  buttonText: buttonName,
                ),
              ),


            ],
          ),
        ),
    );
  }
}
