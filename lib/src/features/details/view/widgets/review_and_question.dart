import 'package:flutter/material.dart';

class ReviewAndQuestion extends StatelessWidget {
  const ReviewAndQuestion({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium,),
              const Icon(Icons.add)
            ],
          ),
        ),
      ),
    );
  }
}


