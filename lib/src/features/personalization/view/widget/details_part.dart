import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

import 'details_card.dart';

class DetailsCardPart extends StatelessWidget {
  const DetailsCardPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailsCard(
            cardText: 'Orders',
            onTap: (){}),
        const Gap(AppSizes.spaceBtwItems),
        DetailsCard(
            cardText: 'Account Details',
            onTap: (){}),
        const Gap(AppSizes.spaceBtwItems),
        DetailsCard(
            cardText: 'Wishlist',
            onTap: (){}),
        const Gap(AppSizes.spaceBtwItems),
        DetailsCard(
            cardText: 'Address',
            onTap: (){}),
        const Gap(AppSizes.spaceBtwItems),
      ],
    );
  }
}

