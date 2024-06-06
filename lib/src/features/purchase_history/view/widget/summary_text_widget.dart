import 'package:flutter/material.dart';

class AppSummaryTextWidget extends StatelessWidget {
  const AppSummaryTextWidget({super.key, required this.title, required this.amount});

  final String title, amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge,),
        Text(amount, style: Theme.of(context).textTheme.titleLarge)
      ],
    );
  }
}

