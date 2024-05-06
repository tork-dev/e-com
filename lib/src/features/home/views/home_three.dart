import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/gridview_layout/gridview_layout.dart';
import 'package:torganic/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/common/widgets/containers/grid_scroll_card.dart';
import 'package:torganic/src/common/widgets/containers/horizontal_scroll_card.dart';
import 'package:torganic/src/common/widgets/containers/product_image.dart';
import 'package:torganic/src/common/widgets/search_bar/search_bar.dart';
import 'package:torganic/src/common/widgets/slider/view/app_slider.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import '../../../utils/constants/image_strings.dart';

class HomeThree extends StatelessWidget {
  const HomeThree({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final isDark = AppHelperFunctions.isDarkMode(context);
    return AppLayoutWithDrawer(
        globalKey: controller.homeKey,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
                child: Image.asset(AppImages.darkAppLogo1)),
            SizedBox(
              child: Row(
                  children: [
                    Text('Hi, User'), 
                    AppCardContainer(
                      height: 50,
                      //borderRadius: 100,
                        borderColor: Colors.red,
                        child: Icon(Icons.verified_user))
              ]))
          ],
        ),
        body: ListView(
          children:  [
            const AppSearchBar(),
            const Gap(AppSizes.spaceBtwItems),
            const CustomSlider(
              items: [
                AppImages.banner1,
                AppImages.banner2,
                AppImages.banner3,
              ],
            ),
            const Gap(AppSizes.spaceBtwSections),
            AppHorizontalScrollProduct(
                onTap: (){},
              itemCount: 5,
              imgUrl: AppImages.productImage3,
              productName: 'Skin Aqua super Moisture Gel',
              price: '1450',
              ratings: '4',
              reviews: '41',
              salePrice: '1500',
            )
           //  AppListViewLayout(
           //    itemCount: 10,
           //    imgUrl: AppImages.productImage5,
           //  )
          ],
        ));
  }
}
