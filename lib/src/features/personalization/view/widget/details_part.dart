import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/address/view/adress_screen.dart';
import 'package:kirei/src/features/de_active_account/view/de_active_account.dart';
import 'package:kirei/src/features/personalization/view/account_details.dart';
import 'package:kirei/src/features/purchase_history/view/purchace_history.dart';
import 'package:kirei/src/features/wishlist/view/wishlist.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import 'details_card.dart';

class DetailsCardPart extends StatelessWidget {
  const DetailsCardPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailsCard(
          onTap: ()=> Get.to(()=> const PurchaseHistory()),
            cardText: 'Orders',
           ),
        const Gap(AppSizes.spaceBtwItems),
        DetailsCard(
            cardText: 'Account Details',
            onTap: ()=> Get.to(()=> const AccountDetailsScreen())),
        const Gap(AppSizes.spaceBtwItems),
        DetailsCard(
            cardText: 'Wishlist',
            onTap: ()=> Get.to(()=> const WishlistScreen())),
        const Gap(AppSizes.spaceBtwItems),
        DetailsCard(
            cardText: 'Address',
            onTap: ()=> Get.to(()=> const AddressScreen())),
        const Gap(AppSizes.spaceBtwItems),
        DetailsCard(
            cardText: 'Delete Account',
            onTap: ()=> Get.to(()=> const DeActiveAccount())),
        const Gap(AppSizes.spaceBtwItems),

      ],
    );
  }
}

