import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/features/group_shopping/controller/group_shopping_controller.dart';
import 'package:kirei/src/features/group_shopping/view/widgets/group_checkout_alert.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../utils/logging/logger.dart';

class GroupShoppingPaymentScreen extends StatelessWidget {
  const GroupShoppingPaymentScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final groupShoppingController = GroupShoppingController.instance;
    final token = Get.parameters["id"];
    final productId = Get.parameters["productId"];
    final buttonName = Get.parameters["buttonName"];
    final buttonWork = Get.parameters["buttonWork"];

    return  AppLayoutWithBackButton(
      title: const Text('Group Shopping', style: TextStyle(color: AppColors.secondary),),
        centerTitle: true,
        body: Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.defaultSpace),
          child: GroupCheckoutAlert(
            buttonName: buttonName ?? "JOIN GROUP",
            buttonWork: (){
              Log.d('button tapped');
              buttonWork == "createGroup" ? groupShoppingController.createGroup(int.parse(productId!)) : groupShoppingController.joinGroup(token!, int.parse(productId!));
            },
          ),
        ));
  }
}

