import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import 'package:kirei/src/utils/logging/logger.dart';
import '../../../features/ai_recommendation/model/products_response.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/local_storage/local_storage_keys.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../layouts/listview_layout/listview_layout.dart';
import '../../styles/skeleton_style.dart';
import 'vertical_product_card.dart';

class AppHorizontalScrollProductCard extends StatelessWidget {
  const AppHorizontalScrollProductCard({super.key, this.sectionName});

  final List? sectionName;

  @override
  Widget build(BuildContext context) {
    // final cartController = CartController.instance;
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
                            if (sectionName![index].stock == 0) {
                              AppHelperFunctions.showToast(
                                "Product is not in stock",
                              );
                              return;
                            }
                            if (AppLocalStorage().readData(
                                      LocalStorageKeys.isLoggedIn,
                                    ) ==
                                    null &&
                                sectionName![index].requestAvailable != 0) {
                              Get.toNamed(
                                '/login/cart',
                                parameters: {
                                  'product_id':
                                      sectionName![index].id.toString(),
                                  'product_slug': sectionName![index].slug!,
                                  'sale_price':
                                      sectionName![index].salePrice.toString(),
                                  'request_available':
                                      sectionName![index].requestAvailable
                                          .toString(),
                                  'preorder_available':
                                      sectionName![index].preorderAvailable
                                          .toString(),
                                },
                              );
                            } else if (sectionName![index].requestAvailable !=
                                0) {
                              cartController
                                  .getRequestResponse(
                                    productId: sectionName![index].id!,
                                  )
                                  .then(
                                    (value) => AppHelperFunctions.showToast(
                                      cartController
                                          .requestStockResponse
                                          .value
                                          .message!,
                                    ),
                                  );
                            } else if (sectionName![index].requestAvailable !=
                                0) {
                              cartController
                                  .getRequestResponse(
                                    productId: sectionName![index].id!,
                                  )
                                  .then(
                                    (value) => AppHelperFunctions.showToast(
                                      cartController
                                          .requestStockResponse
                                          .value
                                          .message!,
                                    ),
                                  );
                            } else {
                              cartController.getAddToCartResponse(
                                sectionName![index],
                              );
                            }

                            // EventLogger().logAddToCartEvent('${sectionName![index].slug}',
                            //     sectionName![index].salePrice!);
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
