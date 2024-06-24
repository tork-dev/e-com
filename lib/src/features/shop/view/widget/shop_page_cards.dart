import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/containers/vertical_product_card.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';
import 'package:torganic/src/features/shop/controller/get_shop_data_controller.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

import '../../../../common/layouts/gridview_layout/gridview_layout.dart';
import '../../../../common/styles/app_dividers.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/local_storage/local_storage_keys.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../authentication/views/log_in/view/login.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../../details/view/details.dart';
import 'sub_category.dart';

class AppShopGridScrollCard extends StatelessWidget {
  const AppShopGridScrollCard({super.key});

  @override
  Widget build(BuildContext context) {
    final shopController = GetShopDataController.instance;
    final homeController = HomeController.instance;
    final cartController = CartController.instance;
    return Obx(() {
      print('/////////hsdfjkskfjs//////////////');
     // print(shopController.shopPageProduct.value.data!.length);
      return Column(
        children: [
          Visibility(
            visible: shopController.isFromCategory.value,
              child: const ShopSubCategory()),
          const Gap(AppSizes.sm),
          AppGridViewLayout(
                itemCount: shopController.hittingApi.value
                    ? 10
                    : shopController.shopPageProduct.value.data!.length,
                builderFunction: (context, index) => shopController.hittingApi.value
                    ? ShimmerHelper().buildBasicShimmer(height: 150, width: 150)
                    : shopController.shopPageProduct.value.data!.isEmpty? const Center(child: Text('No Product Found'),) : AppVerticalProductCard(
                        onTap: () {
                          Get.to(() => DetailsPage(
                            productSlug: shopController.shopPageProduct.value.data![index].slug!,
                            productId: shopController.shopPageProduct.value.data![index].id!,
                          ));
                        },
                        onCartTap: () {
                          if (AppLocalStorage()
                                  .readData(LocalStorageKeys.isLoggedIn) !=
                              null) {
                            homeController
                                .getAddToCartResponse(
                                shopController.shopPageProduct.value.data![index].id!,
                                1,
                                shopController.shopPageProduct.value.data![index].preorderAvailable)
                                .then((value) => {
                                      cartController.cartCount.value = homeController
                                          .addToCartResponse.value.cartQuantity!,
                                      AppHelperFunctions.showToast(homeController
                                          .addToCartResponse.value.message!)
                                    });
                          } else {
                            Get.to(() => const LogIn());
                          }
                        },
                        productName:
                            shopController.shopPageProduct.value.data![index].name ??
                                '',
                        ratings: shopController
                            .allProducts[index].ratings!
                            .toDouble(),
                        imgUrl: shopController.shopPageProduct.value.data![index]
                                .pictures![0].url ??
                            '',
                        reviews: shopController
                                .allProducts[index].reviews ??
                            0,
                        salePrice: shopController
                                .allProducts[index].salePrice?.toInt() ??
                            0,
                        price:
                            shopController.shopPageProduct.value.data![index].price?.toInt() ??
                                0,
                        buttonName: shopController.shopPageProduct.value.data![index]
                                    .preorderAvailable ==
                                0
                            ? shopController
                                        .allProducts[index].stock !=
                                    0
                                ? 'ADD TO CART'
                                : "OUT OF STOCK"
                            : 'PREORDER',
                        backgroundColor: shopController.shopPageProduct.value
                                    .data![index].preorderAvailable ==
                                0
                            ? shopController
                                        .allProducts[index].stock !=
                                    0
                                ? AppColors.secondary
                                : AppColors.primary
                            : AppColors.preorder,
                        isDiscountAvailable: shopController
                                .allProducts[index].salePrice !=
                            shopController.shopPageProduct.value.data![index].price,
                        isNetworkImage: true,
                        discount: shopController
                                .allProducts[index].discount!.toInt() ??
                            0,
                        isStockAvailable:
                            shopController.shopPageProduct.value.data![index].stock !=
                                0,
                      )),
        ],
      );
    });
  }
}
