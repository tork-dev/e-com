import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/checkout/controller/checkout_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class AppCouponField extends StatelessWidget {
  const AppCouponField({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
    return AppCardContainer(
      height: 40,
      hasBorder: true,
        padding: EdgeInsets.zero,
        applyRadius: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: AppHelperFunctions.screenWidth() * .5,
          child: TextFormField(
            controller: checkoutController.couponController,
            cursorColor: AppColors.primary,
            decoration: const InputDecoration(
              hintText: 'Enter coupon code',
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
              contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: 0),
            ),
          ),
        ),
         Obx(() {
             return AppCardContainer(
               onTap: (){
                 !checkoutController.isCouponApplied.value? checkoutController.onCouponApplied() : checkoutController.onCouponRemove();
               },
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                applyRadius: false,
                backgroundColor:  checkoutController.isCouponApplied.value? AppColors.primary : AppColors.secondary,
                child: Center(
                  child: Text(
                    checkoutController.isCouponApplied.value? "REMOVE" :
                      "APPLY COUPON",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: AppColors.white)),
                ));
           }
         )
      ],
    ));
  }
}
