import 'package:flutter/material.dart';

class SummaryTextWidget extends StatelessWidget {
  const SummaryTextWidget({super.key, required this.title, required this.amount});

  final String title, amount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge,),
          Text(amount, style: Theme.of(context).textTheme.titleLarge)
        ],
      ),
    );
  }
}

