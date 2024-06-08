import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/cart/controllers/cart_controller.dart';
import '../../../features/authentication/views/log_in/view/login.dart';
import '../../../features/details/view/details.dart';
import '../../../features/home/controller/home_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../layouts/listview_layout/listview_layout.dart';
import '../../styles/skeleton_style.dart';
import 'vertical_product_card.dart';

class AppHorizontalScrollProductCard extends StatelessWidget {
  const AppHorizontalScrollProductCard({
    super.key,
    this.sectionName,
  });

  final List? sectionName;

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final cartController = CartController.instance;
    return SizedBox(
        height: sectionName == null ? 170 : 270,
        child: AppListViewLayout(
            isScrollVertically: false,
            itemCount: sectionName == null ? 5 : sectionName!.length,
            builderFunction: (context, index) => sectionName == null
                ? ShimmerHelper().buildBasicShimmer(width: 150)
                : AppVerticalProductCard(
                    height: 150,
                    width: 150,
                    onTap: () {
                      Get.to(() => DetailsPage(
                            productSlug: sectionName![index].slug!,
                        productId: sectionName![index].id!,
                          ));
                    },
                    onCartTap: () {
                      if (AppLocalStorage()
                              .readData(LocalStorageKeys.isLoggedIn) !=
                          null) {
                        homeController
                            .getAddToCartResponse(sectionName![index].id, 1,
                                sectionName![index].preorderAvailable)
                            .then((value) => {
                              cartController.cartCount.value = homeController.addToCartResponse.value.cartQuantity!,
                                  AppHelperFunctions.showToast(homeController
                                      .addToCartResponse.value.message!)
                                });
                      } else {
                        Get.to(() => const LogIn());
                      }
                    },
                    productName: sectionName![index].name!,
                    ratings: sectionName![index].ratings!.toDouble(),
                    reviews: sectionName![index].reviews!,
                    salePrice: sectionName![index].salePrice!,
                    price: sectionName![index].price!,
                    imgUrl: sectionName![index].pictures![0].url!,
                    isStockAvailable: sectionName![index].stock != 0,
                    buttonName: sectionName![index].preorderAvailable == 0
                        ? sectionName![index].stock != 0
                            ? 'ADD TO CART'
                            : 'OUT OF STOCK'
                        : 'PREORDER NOW',
                    backgroundColor: sectionName![index].preorderAvailable == 0
                        ? sectionName![index].stock != 0
                            ? AppColors.secondary
                            : AppColors.primary
                        : AppColors.preorder,
                    isNetworkImage: true,
                    isDiscountAvailable: sectionName![index].discount != 0,
                    discount: sectionName![index].discount!,
                  )));
  }
}
