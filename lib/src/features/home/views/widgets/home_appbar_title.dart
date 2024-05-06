import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/image_strings.dart';

class AppHomeAppBarTitle extends StatelessWidget {
  const AppHomeAppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 70,
            child: Image.asset(AppImages.darkAppLogo)),
         SizedBox(
            child: Row(
                children: [
                  Text('Hi, User', style: Theme.of(context).textTheme.bodyLarge,),
                  const Gap(AppSizes.spaceBtwRowItem),
                  const AppCardContainer(
                      height: 40,
                      width: 40,
                      borderRadius: 100,
                      //backgroundColor: Colors.black,
                      hasBorder: true,
                      borderWidth: 1,
                      borderColor: AppColors.secondary,
                      child: Icon(Icons.verified_user))
                ]))
      ],
    );
  }
}