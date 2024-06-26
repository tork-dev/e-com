import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/search_bar/search_widget.dart';
import 'package:torganic/src/features/shop/controller/get_shop_data_controller.dart';

import '../../../utils/constants/colors.dart';

class AppBarSearch extends StatelessWidget {
  final Widget? Function(String txt) onSubmit;
  const AppBarSearch({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AppSearchWidget(
      builder: (context, controller, focusNode)=>
      TextFormField(
        onFieldSubmitted: onSubmit,
        controller: controller,
        focusNode: focusNode,
        cursorColor: AppColors.white,
        style: const TextStyle(color: Colors.white),
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
      ),
    );
  }
}
