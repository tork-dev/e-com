import 'package:flutter/material.dart';

import '../../../../features/bottom_navigation/convex-bottom_navigation.dart';

class AppDrawerCard extends StatelessWidget {
  const AppDrawerCard({
    required this.title, required this.onPress,
    super.key,
  });

  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        title: Text(title.toUpperCase(), style: const TextStyle(fontSize: 13)),
        onTap: ()=> onPress());
  }
}
