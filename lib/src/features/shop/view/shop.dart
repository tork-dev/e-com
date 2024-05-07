import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:torganic/src/common/widgets/buttons/app_buttons.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';


class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopController = Get.put(ShopController());
    return AppLayoutWithDrawer(
        globalKey: shopController.shopKey,
        backgroundColor: AppColors.primary,
        leadingIconColor: AppColors.white,
        hasEndDrawer: true,
        action:  const[
          Icon(Icons.search, color: AppColors.white,),
          Gap(AppSizes.sm),
        ],
        title: TextFormField(
          cursorColor: AppColors.white,
          decoration:  InputDecoration(
            hintText: 'Search with AI (EX: Facewash for acne)',
            hintStyle: Theme.of(context).textTheme.bodySmall!.apply(color: AppColors.white),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          ),
        ),
        body: ListView(
          children: [
            Gap(AppSizes.spaceBtwItems),
            AppButtons.largeFlatFilledButton(
                onPressed: ()=> shopController.shopKey.currentState!.openEndDrawer(),
                buttonText: 'open')
          ],
        ));
  }
}

