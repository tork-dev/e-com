import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/widgets/buttons/app_buttons.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/authentication/views/log_in/view/login.dart';
import 'package:torganic/src/features/cart/controllers/cart_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/image_strings.dart';

class CartLogOutView extends StatelessWidget {
  const CartLogOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.profileIcon),
            Gap(AppHelperFunctions.screenHeight() * 0.07),
             Text(
              "Please log in to see the cart items",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Gap(AppHelperFunctions.screenHeight() * 0.05),
            SizedBox(
                width: AppHelperFunctions.screenWidth() * 0.5,
                child: AppButtons.largeFlatFilledButton(
                    backgroundColor: AppColors.secondary,
                    onPressed: () {
                      Get.to(()=> const LogIn());
                    },
                    buttonText: "Login Now"))
          ],
        ));
  }
}
