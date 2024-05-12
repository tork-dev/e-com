import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/common/widgets/buttons/app_buttons.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/device/device_utility.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class AppCartProceedButton extends StatelessWidget {
  const AppCartProceedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      height: 150,
      width: AppHelperFunctions.screenWidth() * 1,
      backgroundColor: AppColors.white,
        applyRadius: false,
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: AppDeviceUtils.getBottomNavigationBarHeight() - 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
               width: AppHelperFunctions.screenWidth() * 1,
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('SubTotal', style: Theme.of(context).textTheme.titleLarge,),
                  Text('৳3130.00', style: Theme.of(context).textTheme.titleLarge,)
                ],
                           ),
             ),
            const Gap(AppSizes.spaceBtwItems),
            AppButtons.largeFlatFilledButton(onPressed: (){}, buttonText: 'PROCEED TO CHECKOUT', backgroundColor: AppColors.secondary)
          ],
        ));
  }
}

