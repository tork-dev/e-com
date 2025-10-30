import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_without_appbar/layout_without_appbar.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../common/widgets/containers/card_container.dart';


class GroupOrderStatusScreen extends StatelessWidget {
  final String statusString;
  final bool status;


  const GroupOrderStatusScreen(
      {super.key,
      required this.statusString,
      this.status = false});

  @override
  Widget build(BuildContext context) {

    return AppLayoutWithoutAppBar(
        title: const Text(
          'Payment Status',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppCardContainer(
              padding: const EdgeInsets.all(AppSizes.md),
              borderWidth: 3,
              borderColor: status ? Colors.green : Colors.red,
              hasBorder: true,
              child: Row(
                children: [
                  AppButtons.smallRoundButton(
                      onPressed: () {},
                      buttonColor: status ? Colors.green : Colors.red,
                      buttonChild:
                      Icon(status ? Icons.done : Icons.close)),
                  const Gap(AppSizes.sm),
                  Text(
                    statusString,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
           const Gap(AppSizes.appBarHeight),
            SizedBox(
                width: 200,
                child: AppButtons.largeFlatFilledButton(
                    onPressed: () {
                      Get.offAllNamed("/home");
                    },
                    buttonText: 'Home',
                    backgroundColor: AppColors.secondary))
          ],
        )
    );
  }
}
