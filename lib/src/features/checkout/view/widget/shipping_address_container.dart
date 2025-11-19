import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/checkout/controller/checkout_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../../utils/logging/logger.dart';
import '../../../address/view/widgets/all_address_fields.dart';

class AppShippingAddressContainer extends StatelessWidget {
  const AppShippingAddressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
        return Obx(() {
          Log.d('address check ${checkoutController.addressController.hasData}');
            return AppCardContainer(
              padding: const EdgeInsets.only(top: AppSizes.sm, bottom: AppSizes.sm),
              backgroundColor: AppColors.white,
              child: !checkoutController.addressController.hasData
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppAllAddressFields(isCallSummary: true,),
                    )
                  : ExpansionTile(
                      title: RichText(
                          text: TextSpan(
                              text: 'Deliver to',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                            TextSpan(
                                text:
                                    ' ${checkoutController.addressController.addressController.value.text}',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))
                          ])),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(AppSizes.spaceBtwDefaultItems),
                          Text(
                            '${checkoutController.addressController.nameController.value.text}  |  ${checkoutController.addressController.phoneController.text}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                           AppCardContainer(
                              margin: EdgeInsets.only(left: 32, top: 16, bottom: 8),
                              height: 36,
                              hasBorder: true,
                              borderColor: AppColors.lightGrey,
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                'Change Delivery Address',
                                style: Theme.of(context).textTheme.labelLarge?.apply(color: Colors.green),
                              ))),
                        ],
                      ),
                      trailing: const SizedBox(
                        width: 0,
                      ),
                      children: [
                        Container(
                          height: 10,
                          color: AppColors.light,
                        ),
                        const AppCardContainer(
                          applyRadius: true,
                          padding: EdgeInsets.all(8.0),
                          child: AppAllAddressFields(isCallSummary: true,),
                        ),
                      ],
                    ),
            );
          }
        );
  }
}
