import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/layouts/layout_with_back_button/layout_with_back_button.dart';
import '../../../common/widgets/buttons/app_buttons.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../controller/feedback_controller.dart';
import 'widget/message_form.dart';
import 'widget/trouble_checklist.dart';

class FeedbackForm extends StatelessWidget {
  const FeedbackForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedbackController());
    final isDark = AppHelperFunctions.isDarkMode(context);
    return AppLayoutWithBackButton(
        title: const Text('Feedback'),
        padding: AppSizes.defaultSpace,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please select the type of the feedback',
                style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: isDark ? AppColors.darkGrey : AppColors.grey)),
            Obx(
                ()=> TroubleChecklist(
                title: 'Login Trouble',
                value: controller.loginTrouble.value,
                onChanged: (value){
                  controller.loginTrouble.value = !controller.loginTrouble.value;
                }
              ),
            ),
            Obx(
                ()=> TroubleChecklist(
                  title: 'Phone number related',
                  value: controller.phoneNumberTrouble.value,
                  onChanged: (value) {
                    controller.phoneNumberTrouble.value =
                        !controller.phoneNumberTrouble.value;
                  }),
            ),
            Obx(
                  ()=> TroubleChecklist(
                  title: 'Personal Profile',
                  value: controller.personalProfileTrouble.value,
                  onChanged: (value) {
                    controller.personalProfileTrouble.value =
                    !controller.personalProfileTrouble.value;
                  }),
            ),
            Obx(
                  ()=> TroubleChecklist(
                  title: 'Other Issue',
                  value: controller.otherTrouble.value,
                  onChanged: (value) {
                    controller.otherTrouble.value =
                    !controller.otherTrouble.value;
                  }),
            ),
            const Gap(AppSizes.spaceBtwSections),
            const MessageForm(),
            const Gap(AppSizes.spaceBtwSections),
            AppButtons.largeFlatFilledButton(
                onPressed: (){},
                buttonText: AppLocalizations.of(context)!.submit)
          ],
        ));
  }
}


