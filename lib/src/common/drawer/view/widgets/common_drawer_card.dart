import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/colors.dart';

import '../../../../features/bottom_navigation/convex-bottom_navigation.dart';

class AppDrawerCard extends StatelessWidget {
  const AppDrawerCard({
    required this.title, required this.onPress, this.titleColor = AppColors.light,
    super.key,
  });

  final String title;
  final VoidCallback onPress;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge!.apply(color: titleColor)),
        onTap: ()=> onPress());
  }
}
