import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../checkout/model/checkout_summary_respopnse.dart';
import '../../../checkout/view/checkout_screen.dart';

class AppCartProceedButton extends StatelessWidget {
  const AppCartProceedButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return AppCardContainer(
      // height: 150,
      width: AppHelperFunctions.screenWidth(),
      backgroundColor: AppColors.white,
        applyRadius: false,
        padding: const EdgeInsets.all(16),
        // margin: EdgeInsets.only(bottom: AppDeviceUtils.getBottomNavigationBarHeight() - 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
               width: AppHelperFunctions.screenWidth(),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('SubTotal', style: Theme.of(context).textTheme.titleMedium,),
                  Obx(() {
                      return Text('৳${cartController.cartItemTotalPrice}', style: Theme.of(context).textTheme.titleMedium,);
                    }
                  )
                ],
                           ),
             ),
            const Gap(AppSizes.spaceBtwDefaultItems),
            AppButtons.largeFlatFilledButton(
                onPressed: () async{
                  CheckoutSummaryResponse? checkoutSummaryResponse = await cartController.getCheckoutSummary();
                  if (checkoutSummaryResponse!.result == true) {
                    Get.to(() => CheckoutScreen());
                  }

                },
                buttonText: 'Proceed to Checkout', backgroundColor: AppColors.secondary)
          ],
        ));
  }
}

