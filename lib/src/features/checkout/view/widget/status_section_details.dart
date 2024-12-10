import 'package:flutter/material.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/features/purchase_history/controller/purchase_history_details_controller.dart';

class AppOrderStatusDetailsSection extends StatelessWidget {
  const AppOrderStatusDetailsSection({super.key, required this.title, required this.subTitle});

  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
             subTitle,
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
        AppDividersStyle.fullFlatAppDivider
      ],
    );
  }
}

