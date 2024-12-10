import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/features/address/controller/address_controller.dart';
import 'package:kirei/src/features/address/view/widgets/all_address_fields.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../common/widgets/buttons/app_buttons.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return AppLayoutWithBackButton(
      title: const Text(
        'Address of user',
        style: TextStyle(color: AppColors.secondary),
      ),
        centerTitle: true,
        leadingIconColor: AppColors.darkGrey,
        padding: AppSizes.defaultSpace,
        body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children:  [
            const AppAllAddressFields(),
            const Gap(AppSizes.spaceBtwDefaultItems),
            AppButtons.largeFlatFilledButton(
                backgroundColor: AppColors.secondary,
                onPressed: (){
                  controller.onPressSave();
                },
                buttonText: 'SAVE')
          ],
        ));
  }
}

