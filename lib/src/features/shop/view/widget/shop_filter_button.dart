import 'package:flutter/material.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';

class AppShopFilterButton extends StatelessWidget {
  const AppShopFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      height: 40,
      width: 80,
      borderRadius: 3,
      backgroundColor: AppColors.error,
      child: Center(
          child: Text(
            'CLEAR',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .apply(color: AppColors.white),
          )),
    );
  }
}

