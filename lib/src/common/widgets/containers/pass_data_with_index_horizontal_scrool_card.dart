import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
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

class AppPassDataHorizontalProductCard extends StatelessWidget {
  const AppPassDataHorizontalProductCard(
      {super.key,
      required this.productName,
      required this.productSlug,
      required this.productId,
      required this.imgUrl,
      required this.preOrderAvailable,
      required this.requestAvailable,
      required this.isStockAvailable,
      required this.price,
      required this.salePrice,
      required this.discount,
      required this.reviews,
      required this.ratings});

  final String productName, productSlug, imgUrl;
  final int productId,
      preOrderAvailable,
      requestAvailable,
      reviews,
      salePrice,
      price,
      discount;
  final bool isStockAvailable;
  final double ratings;

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final cartController = CartController.instance;
    return AppVerticalProductCard(
      height: 150,
      width: 150,
      onTap: () {
        Get.to(() => DetailsPage(
              productSlug: productSlug,
            ));
      },
      onCartTap: () {
        if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
          homeController
              .getAddToCartResponse(productId, 1, preOrderAvailable)
              .then((value) => {
                    cartController.cartCount.value =
                        homeController.addToCartResponse.value.cartQuantity!,
                    AppHelperFunctions.showToast(
                        homeController.addToCartResponse.value.message!)
                  });
        } else {
          Get.to(() => const LogIn());
        }
      },
      productName: productName,
      ratings: ratings,
      reviews: reviews,
      salePrice: salePrice,
      price: price,
      imgUrl: imgUrl,
      isStockAvailable: isStockAvailable,
      buttonName: isStockAvailable
          ? 'ADD TO CART'
          : preOrderAvailable == 0
              ? requestAvailable == 0
                  ? 'OUT OF STOCK'
                  : "REQUEST STOCK"
              : 'PREORDER NOW',
      backgroundColor: isStockAvailable
          ? AppColors.secondary
          : preOrderAvailable == 0
              ? requestAvailable == 0
                  ? AppColors.primary
                  : AppColors.request
              : AppColors.preorder,
      isNetworkImage: true,
      isDiscountAvailable: discount != 0,
      discount: discount,
      buttonColor:
          requestAvailable == 0 ? AppColors.white : AppColors.secondary,
    );
  }
}
