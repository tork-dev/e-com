import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../containers/card_container.dart';

class AppBottomButton extends StatelessWidget {
  const AppBottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppCardContainer(
            height: 50,
            width: AppHelperFunctions.screenWidth() / 2,
            applyRadius: false,
            backgroundColor: AppColors.secondary,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_bag_outlined, color: AppColors.white, size: 20,),
                Text(' Add To Cart', style: Theme.of(context).textTheme.titleMedium!.apply(color: AppColors.white),)],)),
        AppCardContainer(
            height: 50,
            width: AppHelperFunctions.screenWidth() / 2,
            applyRadius: false,
            backgroundColor: AppColors.primary,
            child: Center(child: Text('Buy Now', style: Theme.of(context).textTheme.titleMedium!.apply(color: AppColors.white)))),
      ],);
  }
}
