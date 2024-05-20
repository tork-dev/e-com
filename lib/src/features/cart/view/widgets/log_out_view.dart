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
  const CartLogOutView({super.key, required this.imgUrl, required this.titleText, required this.buttonName, required this.onTap});

  final String imgUrl, titleText, buttonName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imgUrl),
        Gap(AppHelperFunctions.screenHeight() * 0.02),
         Text(
          titleText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Gap(AppHelperFunctions.screenHeight() * 0.03),
        SizedBox(
            width: AppHelperFunctions.screenWidth() * 0.5,
            child: AppButtons.largeFlatFilledButton(
                backgroundColor: AppColors.secondary,
                onPressed: onTap,
                buttonText: buttonName))
      ],
    );
  }
}
