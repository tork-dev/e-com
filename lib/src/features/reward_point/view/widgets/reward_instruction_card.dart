import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

  final String imgUrl, title;
  final List<String> subTitle;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        applyRadius: false,
        width: AppHelperFunctions.screenWidth(),
        hasBorder: true,
        borderColor: AppColors.lightGrey,
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: ListTile(
            // contentPadding: EdgeInsets.symmetric(vertical:AppSizes.sm ),
            isThreeLine: true,
            leading: Image.asset(imgUrl),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Column(
              children: [
                const Gap(AppSizes.sm),
                Column(
                  children: subTitle
                      .map((e) => Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                      Icons.check_circle_outline_outlined),
                                  const Gap(AppSizes.sm),
                                  Expanded(
                                    child: Text(e,
                                        style: const TextStyle(height: 1.2)),
                                  ),
                                ],
                              ),
                              const Gap(AppSizes.sm),
                              // Optional: Add spacing between items
                            ],
                          ))
                      .toList(),
                ),
                const Gap(AppSizes.md),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('view details', style: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.primary),),
                    const Gap(AppSizes.sm),
                    const Icon(Icons.arrow_forward_ios_sharp, size: 12, color: AppColors.primary,)
                  ],
                )
              ],
            )));
  }
}
