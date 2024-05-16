import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.white,
      decoration: InputDecoration(
        hintText: 'Search with AI (EX: Facewash for acne)',
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .apply(color: AppColors.white),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
    );
  }
}
