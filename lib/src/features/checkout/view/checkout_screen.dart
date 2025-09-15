import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/texts/section_title_text.dart';
import 'package:kirei/src/features/address/view/widgets/address_text_field.dart';
import 'package:kirei/src/features/cart/model/cart_get_response_model.dart';
import 'package:kirei/src/features/checkout/controller/checkout_controller.dart';
import 'package:kirei/src/features/checkout/model/checkout_summary_respopnse.dart';
import 'package:kirei/src/features/checkout/view/widget/checkout_summary.dart';
import 'package:kirei/src/features/checkout/view/widget/coupon_field.dart';
import 'package:kirei/src/features/checkout/view/widget/payment_method_type.dart';
import 'package:kirei/src/features/checkout/view/widget/redeem_point_part.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../utils/constants/colors.dart';
import '../../cart/model/cart_local_model.dart';
import 'widget/checkout_order_product_card.dart';
import 'widget/shipping_address_container.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    return AppLayoutWithBackButton(
      padding: 0,
      backgroundColor: AppColors.white,
      bodyBackgroundColor: AppColors.secondaryBackground,
      leadingIconColor: AppColors.darkGrey,
      title: const Text(
        'Checkout',
        style: TextStyle(color: AppColors.secondary),
      ),
      centerTitle: true,
      bottomNav: AppButtons.largeFlatFilledButton(
        onPressed: () {
          controller.onPressProceedToCheckout();
        },
        applyRadius: false,
        buttonText: 'PLACE MY ORDER',
      ),
      body: AppLayoutWithRefresher(
          onRefresh: controller.onRefresh,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Column(
                children: [
                  const Gap(AppSizes.sm),
                  const AppSectionTitleText(
                    sectionTitle: 'Shipping Details',
                    haveTxtButton: false,
                  ),
                  const AppShippingAddressContainer(),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  const AppSectionTitleText(
                    sectionTitle: 'Your Order',
                    haveTxtButton: false,
                  ),
                  AppCheckoutOrderProductsCard(
                    productsList: controller.cartController.allCartProducts,
                  ),
                  const AppCheckoutSummary(),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  const AppCouponField(),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  const RedeemPointPart(),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  const AppSectionTitleText(
                    sectionTitle: 'Notes about your order',
                    haveTxtButton: false,
                  ),
                  AppAddressTextField(
                    hintText: 'Notes about your order',
                    controller: controller.notesController,
                    borderColor: AppColors.darkGrey,
                    verticalPadding: AppSizes.md,
                    borderWidth: 1,
                    hasTitle: false,
                  ),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  const AppPaymentMethodType(),
                  const Gap(AppSizes.defaultSpace),
                ],
              ),
            ),
          ],
        )
    );
  }
}
