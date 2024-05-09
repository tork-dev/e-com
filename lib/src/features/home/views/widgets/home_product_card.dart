import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/widgets/containers/horizontal_scroll_card.dart';
import '../../../../common/widgets/containers/vertical_product_card.dart';
import '../../../../utils/constants/image_strings.dart';

class AppHomeProductCard extends StatelessWidget {
  const AppHomeProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    print('this the product response ${homeController.homeProductResponse.value.success}');
    return SizedBox(
      height: 265,
      child: Obx(() {
        print(homeController.homeProductResponse.value.success);
          return FutureBuilder(
            future: homeController.getProductData(),
            builder: (context, snap) {
              if(snap.connectionState == ConnectionState.waiting || homeController.homeProductResponse.value.success == null){
                return AppListViewLayout(
                    isScrollVertically: false,
                    itemCount: 5,
                    builderFunction: (context, index) =>
                    ShimmerHelper().buildBasicShimmer(
                        height: 250,
                        width: 150
                    ));
                }else {
                return AppListViewLayout(
                    isScrollVertically: false,
                    itemCount: homeController.homeProductResponse.value
                        .newProducts!.length,
                    builderFunction: (context, index) =>

                        Image.network(homeController.homeProductResponse.value
                            .bestsellingProducts![index].pictures![0].url!)

                  // AppVerticalProductCard(
                  //       //height: height,
                  //       width: 150,
                  //       onTap: () {},
                  //       onCartTap: () {},
                  //       productName: homeController.homeProductResponse.value
                  //               .bestsellingProducts![index].name ??
                  //           'name',
                  //       ratings: homeController
                  //           .homeProductResponse.value.bestsellingProducts![index].ratings!,
                  //       reviews: homeController
                  //           .homeProductResponse.value.bestsellingProducts![index].reviews!,
                  //       salePrice: homeController.homeProductResponse.value.bestsellingProducts![index].salePrice!,
                  //       price: homeController
                  //           .homeProductResponse.value.bestsellingProducts![index].price!,
                  //       imgUrl: homeController.homeProductResponse.value.bestsellingProducts![index].pictures![0].url!,
                  //       buttonName: homeController.homeProductResponse.value
                  //                   .bestsellingProducts![index].stock !=
                  //               0
                  //           ? 'ADD TO CART'
                  //           : 'OUT OF STOCK',
                  //       backgroundColor: homeController.homeProductResponse.value
                  //                   .bestsellingProducts![index].stock !=
                  //               0
                  //           ? AppColors.secondary
                  //           : AppColors.primary,
                  //       isNetworkImage: true,
                  //       isDiscountAvailable: homeController.homeProductResponse.value
                  //               .bestsellingProducts![index].discount !=
                  //           0,
                  //       discount: homeController.homeProductResponse.value.bestsellingProducts![index].discount!,
                  // )
                );
              }
            }
          );
        }
      )
    );
  }
}
