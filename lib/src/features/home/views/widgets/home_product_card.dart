import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    print('this the product response ${homeController.homeProductResponse.success}');
    return SizedBox(
      height: 265,
      child: AppListViewLayout(
                isScrollVertically: false,
                itemCount: homeController.homeProductResponse.newProducts!.length,
                builderFunction: (context, index) => homeController.homeProductResponse.success == null?
                    ShimmerHelper().buildBasicShimmer() :
                AppVerticalProductCard(
                      //height: height,
                      width: 150,
                      onTap: () {},
                      onCartTap: () {},
                      productName: homeController.homeProductResponse
                              .bestsellingProducts![index].name ??
                          'name',
                      ratings: homeController
                          .homeProductResponse.bestsellingProducts![index].ratings!,
                      reviews: homeController
                          .homeProductResponse.bestsellingProducts![index].reviews!,
                      salePrice: homeController.homeProductResponse
                          .bestsellingProducts![index].salePrice!,
                      price: homeController
                          .homeProductResponse.bestsellingProducts![index].price!,
                      imgUrl: homeController.homeProductResponse
                          .bestsellingProducts![index].pictures![0].url!,
                      buttonName: homeController.homeProductResponse
                                  .bestsellingProducts![index].stock !=
                              0
                          ? 'ADD TO CART'
                          : 'OUT OF STOCK',
                      backgroundColor: homeController.homeProductResponse
                                  .bestsellingProducts![index].stock !=
                              0
                          ? AppColors.secondary
                          : AppColors.primary,
                      isNetworkImage: true,
                      isDiscountAvailable: homeController.homeProductResponse
                              .bestsellingProducts![index].discount !=
                          0,
                      discount: homeController.homeProductResponse
                          .bestsellingProducts![index].discount!,
                )
                )
    );
  }
}
