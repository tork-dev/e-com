import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppDetailsTagUnderlineWidget extends StatelessWidget {
  const AppDetailsTagUnderlineWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.types,
        this.haveColor = false,
        this.haveUnderLine = true});

  final String title;
  final VoidCallback onTap;
  final List types;
  final bool haveColor, haveUnderLine;

  @override
  Widget build(BuildContext context) {
    GetShopDataController categoryPassingController = GetShopDataController.instance;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.verified_outlined, color: AppColors.darkGrey, size: 18,),
        SizedBox(width: AppSizes.xs,),
        Text(
          title,
          style:Theme.of(context).textTheme.titleMedium?.apply(color: AppColors.darkGrey)
        ),
        ...List.generate(types.length, (index) {
          return InkWell(
            onTap: () {
              categoryPassingController.resetAll();
              if(title == 'Key Ingredients: '){
                Get.offAllNamed('/shop?key_ingredients=${types[index].slug!}');
              }else if(title == 'Tags: '){
                Get.offAllNamed('/shop?tag=${types[index].slug!}');
              }else if(title == 'Categories: '){
                Get.offAllNamed('/shop?category=${types[index].slug!}');
              }
            },
            child: Text(
                "${types[index].name!.substring(0, 1).toUpperCase()}${types[index].name!.substring(1)},  ",
                style: Theme.of(context).textTheme.labelLarge
                )
          );
        }),
      ],
    );
  }
}
