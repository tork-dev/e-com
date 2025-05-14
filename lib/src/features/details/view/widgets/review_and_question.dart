import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';

import '../../../../utils/constants/colors.dart';

class ReviewAndQuestion extends StatelessWidget {
  const ReviewAndQuestion({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AppCardContainer(
        height: 50,
        // applyRadius: false,
        // backgroundColor: AppColors.primary.withAlpha(51),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium,),
              const Icon(CupertinoIcons.forward, color: AppColors.secondary,)
            ],
          ),
        ),
      ),
    );
  }
}


