import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/checkout/controller/checkout_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../address/view/widgets/all_address_fields.dart';

class AppShippingAddressContainer extends StatelessWidget {
  const AppShippingAddressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
        return Obx(() {
          print('address check ${checkoutController.isAddressAvailable.value}');
            return AppCardContainer(
              padding: const EdgeInsets.only(top: AppSizes.sm, bottom: AppSizes.sm),
              backgroundColor: AppColors.white,
              applyRadius: false,
              child: checkoutController.isAddressAvailable.value == false
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppAllAddressFields(),
                    )
                  : ExpansionTile(
                      title: RichText(
                          text: TextSpan(
                              text: 'Deliver to',
                              style: const TextStyle(color: AppColors.secondary),
                              children: [
                            TextSpan(
                                text:
                                    ' ${checkoutController.addressController.addressController.value.text}',
                                style: const TextStyle(fontWeight: FontWeight.bold))
                          ])),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(AppSizes.spaceBtwDefaultItems),
                          Text(
                            '${checkoutController.addressController.nameController.value.text}  |  ${checkoutController.addressController.phoneController.text}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const AppCardContainer(
                              margin: EdgeInsets.only(left: 32, top: 16, bottom: 8),
                              height: 36,
                              hasBorder: true,
                              applyRadius: false,
                              borderColor: AppColors.grey,
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                'Change Delivery Address',
                                style: TextStyle(
                                    color: Colors.green, fontWeight: FontWeight.bold),
                              ))),
                        ],
                      ),
                      trailing: const SizedBox(
                        width: 0,
                      ),
                      children: [
                        Container(
                          height: 10,
                          color: AppColors.lightGrey,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AppAllAddressFields(),
                        ),
                      ],
                    ),
            );
          }
        );
  }
}
