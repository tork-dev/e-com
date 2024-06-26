import 'package:flutter/material.dart';
import 'package:torganic/src/features/shop/controller/get_shop_data_controller.dart';

import '../../../../utils/constants/colors.dart';
import '../../../bottom_navigation/convex_controller.dart';
import '../../controller/home_controller.dart';

class HomeSearchDecoration extends StatelessWidget {
  const HomeSearchDecoration({
    super.key,
    required this.categoryController,
    required this.bottomController,
    required this.controller,
    required this.focusNode,
  });

  final GetShopDataController categoryController;
  final ConvexBottomNavController bottomController;
  final dynamic controller, focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          onFieldSubmitted: (txt) {
            categoryController.search.value = txt;
            categoryController.isFromSearch.value = true;
            categoryController.getShopData();
            bottomController.jumpToTab(1);
          },
          decoration: InputDecoration(
              fillColor: AppColors.grey,
              filled: true,
              focusColor: AppColors.grey,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.secondary,
              ),
              hintText: 'Search with AI (EX: Facewash for acne)',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              suffixIcon: const Icon(Icons.camera_alt),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.grey,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.grey,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(10)))),
    );
  }
}
