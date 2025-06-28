import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/home/controller/search_controller.dart';
import 'package:kirei/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/logging/logger.dart';
import '../../../bottom_navigation/convex_controller.dart';


class HomeSearchDecoration extends StatelessWidget {
  const HomeSearchDecoration({
    super.key,
    required this.categoryController,
    required this.bottomController,
    required this.controller,
    required this.focusNode,
  });

  final dynamic categoryController;
  final ConvexBottomNavController bottomController;
  final dynamic controller, focusNode;

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(AppSearchController());
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
              focusColor: AppColors.grey,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.grey,
              ),
              hintText: 'Search with AI (EX: Facewash for acne)',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              // suffixIcon: InkWell(
              //     onTap: () {
              //       Log.d('clicked');
              //       searchController.searchByImage();
              //     },
              //     child: const Icon(Icons.camera_alt)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd)),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.grey,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.grey,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd)))),
    );
  }
}
