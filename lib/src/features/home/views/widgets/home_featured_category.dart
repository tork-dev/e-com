import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/styles/spacing_style.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/home/repositories/home_repositories.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class AppFeatureCategories extends StatelessWidget {
  const AppFeatureCategories(
      {super.key});


  @override
  Widget build(BuildContext context) {
  final homeController = HomeController.instance;
    return SizedBox(
      height: 100,
      child: Obx(() {
        print('data category: ${homeController.homeFeaturedCategoryResponse.length}');
          return AppListViewLayout(
                  isScrollVertically: false,
                  itemCount: homeController.homeFeaturedCategoryResponse.isEmpty ? 5  : homeController.homeFeaturedCategoryResponse.length,
                  builderFunction: (BuildContext context, int index) =>
                  homeController.homeFeaturedCategoryResponse.isEmpty  ? ShimmerHelper().buildBasicShimmer(
                    height: 150,
                    width: 150
                  ) :
                      Column(
                    children: [
                       AppBannerImage(
                        height: 60,
                        width: 60,
                        isNetworkImage: true,
                        imgUrl: homeController.homeFeaturedCategoryResponse[index].icon ?? 'https://kireibd.com/images/home/categories/New-Arrivals.png',
                      ),

                        //print('this is response' +homeController.homeFeaturedCategoryResponse.length.toString());
                      //      SizedBox(
                      //       height: 60,
                      //         width: 60,
                      //         child: Image.network(homeController.homeFeaturedCategoryResponse[index].icon ?? 'https://kireibd.com/images/home/categories/New-Arrivals.png')
                      //
                      // ),
                      const Gap(8),
                      Text(
                        homeController.homeFeaturedCategoryResponse[index].name!
                        ,
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    ],
                  ));
        }
      )

    );
  }
}