import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:torganic/src/features/details/view/details.dart';
import '../../../../common/layouts/listview_layout/listview_layout.dart';
import '../../../../common/styles/skeleton_style.dart';
import '../../../../common/widgets/containers/vertical_product_card.dart';
import '../../../../utils/constants/colors.dart';
import '../../controller/home_controller.dart';

class AppHomeBestSellingProduct extends StatelessWidget {
  const AppHomeBestSellingProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    return Obx(() {
      // print('this is product ' + homeController.homeProductResponse.value.success.toString());
      return SizedBox(
          height: homeController.homeProductResponse.value.success == null
              ? 170
              : 265,
          child: AppListViewLayout(
              isScrollVertically: false,
              itemCount:
                  homeController.homeProductResponse.value.success == null
                      ? 5
                      : homeController.homeProductResponse.value
                          .bestsellingProducts!.length,
              builderFunction: (context, index) => homeController
                          .homeProductResponse.value.success ==
                      null
                  ?
                  ShimmerHelper().buildBasicShimmer(width: 150)
                  :
                  AppVerticalProductCard(
                      //height: height,
                      width: 150,
                      onTap: () {
                        Get.to(() => DetailsPage(
                              productSlug: homeController.homeProductResponse
                                  .value.bestsellingProducts![index].id!,
                            ));
                      },
                      onCartTap: () {},
                      productName: homeController.homeProductResponse.value
                          .bestsellingProducts![index].name!,
                      ratings: homeController.homeProductResponse.value
                          .bestsellingProducts![index].ratings!.toDouble(),
                      reviews: homeController.homeProductResponse.value
                          .bestsellingProducts![index].reviews!,
                      salePrice: homeController.homeProductResponse.value
                          .bestsellingProducts![index].salePrice!,
                      price: homeController.homeProductResponse.value
                          .bestsellingProducts![index].price!,
                      imgUrl: homeController.homeProductResponse.value
                          .bestsellingProducts![index].pictures![0].url!,
                      isStockAvailable: homeController.homeProductResponse.value
                              .bestsellingProducts![index].stock !=
                          0,
                      buttonName: homeController
                                  .homeProductResponse
                                  .value
                                  .bestsellingProducts![index]
                                  .preorderAvailable ==
                              0
                          ? homeController.homeProductResponse.value
                                      .bestsellingProducts![index].stock !=
                                  0
                              ? 'ADD TO CART'
                              : 'OUT OF STOCK'
                          : 'PREORDER',
                      backgroundColor: homeController
                                  .homeProductResponse
                                  .value
                                  .bestsellingProducts![index]
                                  .preorderAvailable ==
                              0
                          ? homeController.homeProductResponse.value
                                      .bestsellingProducts![index].stock !=
                                  0
                              ? AppColors.secondary
                              : AppColors.primary
                          : AppColors.preorder,
                      isNetworkImage: true,
                      isDiscountAvailable: homeController.homeProductResponse
                              .value.bestsellingProducts![index].discount !=
                          0,
                      discount: homeController.homeProductResponse.value
                          .bestsellingProducts![index].discount!,
                    )));
    });
  }
}
