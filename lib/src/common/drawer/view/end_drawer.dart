import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/styles/spacing_style.dart';
import 'package:torganic/src/common/widgets/buttons/app_buttons.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/common/widgets/texts/section_title_text.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/features/shop/view/widget/price_filter_field.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';


class AppEndDrawer extends StatelessWidget {
  const AppEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final shopController = ShopController.instance;
    return AppCardContainer(
      padding: AppSpacingStyle.paddingWithAppBarHeight,
      width: 300,
      backgroundColor: AppColors.white,
      applyRadius: false,
      child: ListView(
        children: [
          AppCardContainer(
            height: AppHelperFunctions.screenHeight() * .080,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price Range',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Gap(AppSizes.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppPriceFilterField(
                      hintText: 'Minimum',
                      controller: shopController.minimumPriceController,
                    ),
                    AppDividersStyle.smallFlatAppDivider,
                    AppPriceFilterField(
                      hintText: 'Maximum',
                      controller: shopController.maximumPriceController,
                    ),
                  ],
                )
              ],
            ),
          ),
          const Gap(AppSizes.md),
          Obx(() {
            return AppCardContainer(
              height: AppHelperFunctions.screenHeight() * .65,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AppSectionTitleText(
                      sectionTitle: 'Categories',
                      haveTxtButton: false,
                    ),
                    homeController.allCategories.isEmpty
                        ? const Text('No Categories Here')
                        : AppListViewLayout(
                            applyPadding: false,
                            itemCount: homeController.allCategories.length,
                            physics: const BouncingScrollPhysics(),
                            builderFunction:
                                (BuildContext context, int index) => Row(
                              children: [
                                Obx(() {
                                  return Radio(
                                      activeColor: Colors.blueAccent,
                                      value: index,
                                      groupValue: shopController
                                          .selectedCategoryIndex.value,
                                      onChanged: (value) {
                                        shopController
                                            .updateSelectedCategoryIndex(
                                          value!,
                                          homeController
                                              .allCategories[value].name,
                                        );
                                        print(shopController.categories.value);
                                      });
                                }),
                                Text(homeController.allCategories[index].name)
                              ],
                            ),
                          ),
                    const Gap(AppSizes.spaceBtwItems),
                    const AppSectionTitleText(
                      sectionTitle: 'Skin Types',
                      haveTxtButton: false,
                    ),
                    Obx(() {
                      return AppListViewLayout(
                        applyPadding: false,
                        itemCount: shopController
                                .skinTypeResponse.value.skinTypes!.isEmpty
                            ? 5
                            : shopController
                                .skinTypeResponse.value.skinTypes!.length,
                        physics: const BouncingScrollPhysics(),
                        builderFunction: (BuildContext context, int index) =>
                            shopController
                                    .skinTypeResponse.value.skinTypes!.isEmpty
                                ? ShimmerHelper().buildBasicShimmer(height: 30)
                                : Obx(() {
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      dense: true,
                                      title: Text(shopController
                                          .skinTypeResponse
                                          .value
                                          .skinTypes![index]
                                          .title!),
                                      value: shopController.selectedSkinTypes
                                          .contains(shopController
                                              .skinTypeResponse
                                              .value
                                              .skinTypes![index]
                                              .slug!),
                                      onChanged: (value) {
                                        shopController.selectSkinTypes(
                                            shopController
                                                .skinTypeResponse
                                                .value
                                                .skinTypes![index]
                                                .slug!);
                                      },
                                    );
                                  }),
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
           AppCardContainer(
              // height: AppHelperFunctions.screenHeight() * .075,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                width: 100,
                child: AppButtons.largeFlatFilledButton(
                  verticallyPadding: 0,
                    onPressed: (){
                    shopController.resetAll();
                    shopController.getShopData();
                    Get.back();
                    },
                    buttonText: 'CLEAR'),
              ) ,
              SizedBox(
                height: 40,
                width: 100,
                child: AppButtons.largeFlatFilledButton(
                  verticallyPadding: 0,
                    backgroundColor: AppColors.success,
                    onPressed: (){
                    shopController.getShopData();
                    Get.back();
                    },
                    buttonText: 'APPLY'),
              )
            ],
          ))
        ],
      ),
    );
  }
}
