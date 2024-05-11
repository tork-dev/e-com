import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/app_dividers.dart';
import 'package:torganic/src/common/styles/spacing_style.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/common/widgets/texts/section_title_text.dart';
import 'package:torganic/src/features/authentication/views/log_in/view/login.dart';
import 'package:torganic/src/features/feedback/view/feedback_form.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/features/shop/view/widget/price_filter_field.dart';
import 'package:torganic/src/features/shop/view/widget/shop_filter_button.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/device/device_utility.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'widgets/drawer_card.dart';
import 'widgets/header_part.dart';

class AppEndDrawer extends StatelessWidget {
  final String userName, email;

  const AppEndDrawer({required this.userName, required this.email, super.key});

  void _showDialog() {
    //final controller = Get.put(AuthRepositories());
    showDialog(
        context: Get.overlayContext!,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.info),
            title: Text(AppLocalizations.of(context)!.logout),
            content: Text(AppLocalizations.of(context)!.logoutWarning),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                      onPressed: () async {
                        Get.offAll(const LogIn());
                      },
                      child: Text(
                        AppLocalizations.of(context)!.yes,
                      )),
                  CupertinoButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(AppLocalizations.of(context)!.no)),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final shopController = ShopController.instance;
    return AppCardContainer(
      padding: AppSpacingStyle.paddingWithAppBarHeight,
      width: 300,
      backgroundColor: AppColors.white,
      applyRadius: false,
      child: Column(
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
            Obx(() {
                return AppCardContainer(
                  height: AppHelperFunctions.screenHeight() * .70,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const AppSectionTitleText(sectionTitle: 'Categories', haveTxtButton: false,),
                        homeController.allCategories.isEmpty?
                            const Text('No Categories Here') :
                        AppListViewLayout(
                            itemCount: homeController.allCategories.length,
                            physics: const BouncingScrollPhysics(),
                            builderFunction: (BuildContext context, int index)=>
                                Row(
                                  children: [
                                    Radio(value: false, groupValue: 1, onChanged: (onChanged){}),
                                     Text("${homeController.allCategories[index].name!}")
                                  ],),
                        ),
                        const Gap(AppSizes.spaceBtwItems),
                        const AppSectionTitleText(sectionTitle: 'Skin Types', haveTxtButton: false,),
                        AppListViewLayout(
                            itemCount: 100,
                            physics: const BouncingScrollPhysics(),
                            builderFunction: (BuildContext context, int index)=>
                            const Text('test')
                        ),
                      ],
                    )
                    ,
                  ),
                );
              }
            ),

            AppCardContainer(
               // height: AppHelperFunctions.screenHeight() * .075,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppShopFilterButton(),
                    AppShopFilterButton(),
                  ],
                ))
          ],
        ),
    );
  }
}
