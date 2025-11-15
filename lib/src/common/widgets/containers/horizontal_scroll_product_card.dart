import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/home/model/home_products_model.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import '../../../utils/constants/colors.dart';
import '../../layouts/listview_layout/listview_layout.dart';
import '../../styles/skeleton_style.dart';
import 'vertical_product_card.dart';

class AppHorizontalScrollProductCard extends StatelessWidget {
  const AppHorizontalScrollProductCard({super.key, this.sectionName});

  final List<Product>? sectionName;

  @override
  Widget build(BuildContext context) {
    final bottomController = ConvexBottomNavController.instance;
    return SizedBox(
      height: sectionName == null ? 170 : 285,
      child: AppListViewLayout(
        isScrollVertically: false,
        itemCount: sectionName == null ? 5 : sectionName!.length,
        builderFunction:
            (context, index) =>
                sectionName == null
                    ? ShimmerHelper().buildBasicShimmer(width: 150)
                    : GetBuilder<CartController>(
                      builder: (cartController) {
                        return AppVerticalProductCard(
                          height: 150,
                          width: 150,
                          imgHeight: 150,
                          imgWidth: 150,
                          onTap: () {
                            Get.toNamed(
                              '/product/${sectionName![index].slug}',
                              parameters: {'prevRoute': '/home'},
                            );
                            EventLogger().logProductDetailsViewEvent(
                              '${sectionName![index].slug}',
                              sectionName![index].salePrice,
                            );
                          },
                          onCartTap: () {
                            cartController.allCartProducts.any((element) =>
                            element.productId == sectionName![index].id)
                                ? bottomController.jumpToTab(2):
                              cartController.getAddToCartResponse(
                                sectionName![index],
                              );
                          },
                          productName: sectionName![index].name!,
                          ratings: sectionName![index].ratings!.toDouble(),
                          reviews: sectionName![index].reviews!,
                          salePrice: sectionName![index].salePrice!,
                          price: sectionName![index].price!,
                          imgUrl:
                              sectionName?[index].pictures?.isNotEmpty == true
                                  ? sectionName![index].pictures!.first.url ??
                                      ''
                                  : '',
                          isStockAvailable: sectionName![index].stock != 0,
                          buttonName:
                              cartController.allCartProducts.any((element) =>
                                  element.productId == sectionName![index].id)
                                  ? 'View Cart'
                                  :
                              sectionName![index].stock != 0
                                  ? cartController.addingToCartIds.contains(
                                        sectionName![index].id,
                                      )
                                      ? "Adding..."
                                      : 'Add to cart'
                                  : sectionName![index].preorderAvailable == 0
                                  ? sectionName![index].requestAvailable == 0
                                      ? 'Out of stock'
                                      : "Request stock"
                                  : 'Preorder now',
                          backgroundColor:
                              sectionName![index].stock != 0
                                  ? AppColors.addToCartButton
                                  : sectionName![index].preorderAvailable == 0
                                  ? sectionName![index].requestAvailable == 0
                                      ? AppColors.primary
                                      : AppColors.request
                                  : AppColors.preorder,
                          isNetworkImage: true,
                          isDiscountAvailable:
                              sectionName![index].discount != 0,
                          discount: sectionName![index].discount!,
                          buttonColor: AppColors.white,
                        );
                      },
                    ),
      ),
    );
  }
}
