import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/utils/device/device_utility.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'card_container.dart';

class AppProductBottomContainer extends StatelessWidget {
  const AppProductBottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return AppCardContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      backgroundColor: isDark? AppColors.black : AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppCardContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                backgroundColor: AppColors.darkerGrey,
                child: Text('Web Development',
                    style:
                    Theme.of(context).textTheme.labelSmall!.apply(color: AppColors.light)),
              ),
              //const Gap(AppSizes.spaceBtwItems),
              SizedBox(
                child: Row(
                  children: [
                    Text('4.9', style: Theme.of(context).textTheme.labelSmall,),
                    const Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 10,),
                    Text('500', style: Theme.of(context).textTheme.bodySmall)
                  ],
                ),
              )
            ],
          ),
          const Gap(AppSizes.spaceBtwItems),
          Text('The Ultimate Guide to Learning Full Stack', style: Theme.of(context).textTheme.titleMedium,),
          const Gap(AppSizes.spaceBtwItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage('assets/images/user/user_pic.png')),
                        )
                    ),
                    const Gap(AppSizes.spaceBtwRowItem),
                    Text('John Doe', style: Theme.of(context).textTheme.labelLarge,),

                  ],
                ),
              ),
              RichText(text: TextSpan(
                  text: '\$500',
                  style: Theme.of(context).textTheme.labelSmall!.apply(decoration: TextDecoration.lineThrough),
                  children: [
                    TextSpan(
                        text: ' \$100',
                        style: Theme.of(context).textTheme.bodyLarge
                    )
                  ]
              ))
            ],
          )

        ],
      ),
    );
  }
}

