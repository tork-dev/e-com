import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/checkout/controller/checkout_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppPaymentMethodType extends StatelessWidget {
  const AppPaymentMethodType({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
    return AppCardContainer(
        applyRadius: false,
        backgroundColor: AppColors.white,
        padding: const EdgeInsets.all(AppSizes.sm),
        child: Column(
          children: [
            Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 4),
                itemCount: checkoutController.paymentMethods.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Obx(() {
                          return Radio(
                            value: index,
                            groupValue:
                                checkoutController.selectedPaymentMethod.value,
                            onChanged: (value) {
                              checkoutController.selectedPaymentMethod.value =
                                  value!;
                              //print(checkoutController.paymentMethods[index].paymentTypeKey);
                              checkoutController.selectedPaymentMethodName.value =
                                  checkoutController
                                      .paymentMethods[index].paymentTypeKey!;
                              print(checkoutController
                                  .selectedPaymentMethodName.value);
                            },
                            activeColor: Colors.green,
                          );
                        }
                      ),
                      AppBannerImage(
                          isNetworkImage: true,
                          width: 70,
                          imgUrl:
                              checkoutController.paymentMethods[index].image),
                      const Gap(2),
                    ],
                  );
                },
              );
            }),
            const Gap(AppSizes.spaceBtwDefaultItems),
            Row(
              children: [
                Obx(() {
                  return Checkbox(
                      value: checkoutController.isTermsChecked.value,
                      onChanged: (value) {
                        checkoutController.isTermsChecked.value = value!;
                      });
                }),
                const SizedBox(
                    width: 300,
                    child: Text(
                      "I HAVE READ AND AGREE TO THE KIREI'S TERMS AND CONDITIONS, PRIVACY POLICY, AND REFUND POLICY.",
                      style: TextStyle(fontSize: 14),
                    ))
              ],
            ),
          ],
        ));
  }
}
