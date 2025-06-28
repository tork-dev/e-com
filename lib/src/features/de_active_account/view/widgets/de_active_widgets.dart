import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/bottom_navigation/convex_bottom_navigation.dart';
import 'package:kirei/src/features/de_active_account/controller/de_active_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/auth_helper.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class DeActiveWidgets {
  final deActiveController = DeActiveController.instance;

  Widget buildWidgetForTextContent({required String title, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(Get.context!).textTheme.titleLarge,
        ),
        const Gap(AppSizes.sm),
        Text(
          subtitle ?? '',
          style: Theme.of(Get.context!).textTheme.bodyLarge,
        ),
        const Gap(AppSizes.sm),
      ],
    );
  }

  void buildFinalStatusMessage({required String status}) {
    showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        contentPadding: const EdgeInsets.only(
            top: 16.0, left: 2.0, right: 2.0, bottom: 2.0),
        title: Text(
          status,
          maxLines: 3,
          style: const TextStyle(color: AppColors.secondary, fontSize: 14),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(),
              backgroundColor: Colors.green,
            ),
            child: const Text(
              'Ok',
              style: TextStyle(color: AppColors.white),
            ),
            onPressed: () {
              AuthHelper().clearUserData();
              Navigator.of(Get.context!, rootNavigator: true).pop();
              Get.offAllNamed("/home");
              // Navigator.pushAndRemoveUntil(
              //   Get.context!,
              //   MaterialPageRouteNamed(builder: (_) => const HelloConvexAppBar(pageIndex: 0,)),
              //   (route) => false,
              // );
            },
          ),
        ],
      ),
    );
  }

  Obx largeFlatFilledButton() {
    return Obx(() {
      return ElevatedButton(
        onPressed: () {
          if (deActiveController.isChecked.value) {

            AppHelperFunctions.showAlert(
                message: 'Are you sure you want to delete your account?',
                leftButtonName: 'Delete',
                rightButtonName: 'Cancel',
                leftButtonColor: AppColors.primary,
                leftButtonTextColor: AppColors.white,
                onLeftPress: () {
                  Navigator.of(Get.context!, rootNavigator: true).pop();
                  deActiveController.deActiveAccount();
                } ,
                onRightPress: ()=> Navigator.of(Get.context!, rootNavigator: true).pop(),
                rightButtonColor: AppColors.success);

          } else {
            AppHelperFunctions.showToast(
                'You must agree to the terms to delete');
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const BeveledRectangleBorder(),
          backgroundColor: deActiveController.isChecked.value
              ? AppColors.primary
              : AppColors.darkGrey,
        ),
        child: const Text('DELETE ACCOUNT'),
      );
    });
  }

  Widget accountDeletionTermsCondition() {
    return deActiveController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            children: [
              Gap(AppSizes.lg),
              buildWidgetForTextContent(
                  title: '1. Account Deletion',
                  subtitle:
                      'You have the right to delete your account at any time. Upon deletion, your account and associated data will be deactivated and inaccessible to you.'),
              buildWidgetForTextContent(
                  title: '2. Data Retention',
                  subtitle:
                      'For security and legal purposes, we may retain your data for a period of 15 days following your account deletion request. This retention period allows us to address any potential issues or requests you may have before permanent deletion.'),
              buildWidgetForTextContent(
                  title: '3. Data Deletion',
                  subtitle:
                      'After the 15-day retention period, your data will be securely and permanently deleted. This includes any content, messages, preferences, and other information associated with your account.'),
              buildWidgetForTextContent(
                  title: '4. Data Recovery',
                  subtitle:
                      'Please note that once your account and data are deleted, you will not be able to recover them. There is no option to restore your account or data after deletion.'),
              buildWidgetForTextContent(
                  title: '5. Anonymized or Aggregated Data',
                  subtitle:
                      'We may retain anonymized or aggregated data that does not directly identify you for our analytics or legal compliance purposes. This data will not be used to track or profile individual users'),
              buildWidgetForTextContent(
                  title: '6. Changes to this Policy',
                  subtitle:
                      'We reserve the right to modify this policy at any time. We will notify you of any changes by posting the revised policy on our app or website. Your continued use of the app after the revised policy is posted constitutes your acceptance of the changes.'),
              buildWidgetForTextContent(
                  title: '7. Contact Us',
                  subtitle:
                      'If you have any questions regarding account deletion or data retention, please contact us at 09666-791110 (10 AM- 10 PM)'),
              Obx(() {
                return CheckboxListTile(
                    value: deActiveController.isChecked.value,
                    onChanged: (value) {
                      deActiveController.isChecked.value = value!;
                    },
                  title: const Text(
                    'By using our app, you agree to these terms and conditions regarding account deletion and data retention.',
                  ),
                    controlAffinity: ListTileControlAffinity.leading
                );
              }),
              largeFlatFilledButton(),
              const Gap(AppSizes.md)
            ],
          );
  }
}
