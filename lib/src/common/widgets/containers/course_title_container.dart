import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../utils/constants/sizes.dart';
import 'card_container.dart';

class AppCourseTitleContainer extends StatelessWidget {
  const AppCourseTitleContainer({this.height, this.width,super.key});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AppCardContainer(
        height: height,
          width: width,
          padding: const EdgeInsets.fromLTRB(10, 10, 8, 0),
          //backgroundColor: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Python for Data Science and Machine Learning, Build Yo',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              //Gap(AppSizes.spaceBtwRowItem),
              Text('Created by josua', style: Theme.of(context).textTheme.labelMedium,),
              const Text('24 lesson | 10Hrs'),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow,),
                  Text('5.0'),
                  Gap(AppSizes.spaceBtwItems),
                  Icon(Icons.account_circle_rounded, color: Colors.blue, size: 16,),
                  Gap(AppSizes.spaceBtwRowItem),
                  Text('1000')
                ],
              )
            ],
          )),
    );
  }
}

