import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/cart/view/widgets/cart_screen_card.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../common/widgets/texts/section_title_text.dart';

class HomeShopByConcern extends StatelessWidget {
  const HomeShopByConcern({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionTitleText(
            sectionTitle: 'Shop By Concern',
            haveTxtButton: false,
          ),
          const Gap(AppSizes.md),
          SizedBox(
            height: 225,
            child: AppListViewLayout(
                itemCount: 10,
                isScrollVertically: false,
                builderFunction: (context, index) {
                  return  Column(
                    children: [
                      const AppBannerImage(
                          width: 128,
                          applyImageRadius: false,
                          imgUrl: 'assets/images/demo/Acne.png'),
                      AppCardContainer(
                          width: 128,
                          backgroundColor: AppColors.lightGrey,
                          applyRadius: false,
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSizes.spaceBtwDefaultItems),
                          child: Center(
                              child: Text(
                            'Acne',
                            style: Theme.of(context).textTheme.titleLarge,
                          )))
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
