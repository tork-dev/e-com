import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../features/shop/controller/get_shop_data_controller.dart';
import '../../../features/shop/view/widget/price_filter_field.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/logging/logger.dart';
import '../../layouts/listview_layout/listview_layout.dart';
import '../../styles/app_dividers.dart';
import '../../styles/skeleton_style.dart';
import '../../widgets/buttons/app_buttons.dart';
import '../../widgets/containers/card_container.dart';
import '../../widgets/texts/section_title_text.dart';
import '../controller/drawer_controller.dart';

class AppEndDrawer extends StatelessWidget {
  const AppEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.put(AppDrawerController());
    final categoryPassingController = Get.put(GetShopDataController());
    return AppCardContainer(
      padding: const EdgeInsets.only(
        left: AppSizes.defaultSpace,
        right: AppSizes.defaultSpace,
      ),
      width: 300,
      height: AppHelperFunctions.screenHeight(),
      backgroundColor: AppColors.white,
      applyRadius: false,
      child: Column(
        children: [
          // Price Range fixed to top
          AppCardContainer(
            margin: const EdgeInsets.only(top: 50),
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price Range',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Gap(AppSizes.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppPriceFilterField(
                      hintText: 'Minimum',
                      controller:
                          categoryPassingController.minimumPriceController,
                    ),
                    AppDividersStyle.smallFlatAppDivider,
                    AppPriceFilterField(
                      hintText: 'Maximum',
                      controller:
                          categoryPassingController.maximumPriceController,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(AppSizes.sm),

          // Expanded content for scrollable Categories and Skin Types
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Categories Section
                  const AppSectionTitleText(
                    sectionTitle: 'Categories',
                    haveTxtButton: false,
                  ),
                  Obx(() {
                    return drawerController.allNewCategories.isEmpty
                        ? const Text('No Categories Here')
                        : AppListViewLayout(
                            applyPadding: false,
                            itemCount: drawerController.allNewCategories.length,
                            physics: const NeverScrollableScrollPhysics(),
                            builderFunction:
                                (BuildContext context, int index) => Obx(() {
                              return RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                activeColor: AppColors.secondary,
                                value: index,
                                groupValue: categoryPassingController
                                    .selectedCategoryIndex.value,
                                onChanged: (value) {
                                  categoryPassingController
                                      .updateSelectedCategoryIndex(
                                    value!,
                                    drawerController.allNewCategories[value].slug!,
                                  );
                                },
                                dense: true,
                                title: Text(drawerController
                                    .allNewCategories[index].name!),
                              );
                            }),
                          );
                  }),
                  const Gap(AppSizes.spaceBtwDefaultItems),

                  // Skin Types Section
                  const AppSectionTitleText(
                    sectionTitle: 'Skin Types',
                    haveTxtButton: false,
                  ),
                  Obx(() {
                    return AppListViewLayout(
                      applyPadding: false,
                      itemCount: categoryPassingController
                              .skinTypeResponse.value.skinTypes!.isEmpty
                          ? 5
                          : categoryPassingController
                              .skinTypeResponse.value.skinTypes!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      builderFunction: (BuildContext context, int index) =>
                          categoryPassingController
                                  .skinTypeResponse.value.skinTypes!.isEmpty
                              ? ShimmerHelper().buildBasicShimmer(height: 30)
                              : Obx(() {
                                  return CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    dense: true,
                                    title: Text(categoryPassingController
                                        .skinTypeResponse
                                        .value
                                        .skinTypes![index]
                                        .title!),
                                    value: categoryPassingController
                                        .selectedSkinTypes
                                        .contains(categoryPassingController
                                            .skinTypeResponse
                                            .value
                                            .skinTypes![index]
                                            .slug!),
                                    onChanged: (value) {
                                      categoryPassingController.selectSkinTypes(
                                          categoryPassingController
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
          ),

          // Fixed buttons at the bottom
          AppCardContainer(
            // margin: const EdgeInsets.only(bottom: 60),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                  width: 100,
                  child: AppButtons.largeFlatFilledButton(
                    verticallyPadding: 0,
                    onPressed: () {
                      categoryPassingController.resetAll();
                      categoryPassingController.getShopData();
                      Get.back();
                    },
                    buttonText: 'CLEAR',
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: AppButtons.largeFlatFilledButton(
                    verticallyPadding: 0,
                    backgroundColor: AppColors.success,
                    onPressed: () {
                      categoryPassingController.allProducts.clear();
                      categoryPassingController.getShopData();
                      categoryPassingController.categoryRouteList.add('/shop?${categoryPassingController.queryStringValue.value}');
                      Log.d('length of routes: ${categoryPassingController.categoryRouteList}');
                      Get.back();
                    },
                    buttonText: 'APPLY',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

