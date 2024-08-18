import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class RewardInstructionCard extends StatelessWidget {
  const RewardInstructionCard(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.subTitle});

  final String imgUrl, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        applyRadius: false,
        width: AppHelperFunctions.screenWidth(),
        hasBorder: true,
        borderColor: AppColors.lightGrey,
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: ListTile(
          leading: Image.asset(imgUrl),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            subTitle,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ));
  }
}
