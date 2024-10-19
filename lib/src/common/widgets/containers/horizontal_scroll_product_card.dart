import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gtm/gtm.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import '../../../features/authentication/views/log_in/view/login.dart';
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
    final cartController = CartController.instance;
    final gtm = Gtm.instance;
    return SizedBox(
        height: sectionName == null ? 170 : 270,
        child: AppListViewLayout(
            isScrollVertically: false,
            itemCount: sectionName == null ? 5 : sectionName!.length,
            builderFunction: (context, index) =>
            sectionName == null
                ? ShimmerHelper().buildBasicShimmer(width: 150)
                : AppVerticalProductCard(
              height: 150,
              width: 150,
              imgHeight: 150,
              imgWidth: 150,
              onTap: () {
                EventLogger().logProductDetailsViewEvent(
                    '${sectionName![index].slug}');
                Get.reload<DetailsPageController>();
                Get.toNamed('/product/${sectionName![index].slug}');
              },
              onCartTap: () {
                if (AppLocalStorage()
                    .readData(LocalStorageKeys.isLoggedIn) !=
                    null) {
                  EventLogger().logAddToCartEvent('${sectionName![index].slug}',
                      sectionName![index].salePrice!);

                  if (sectionName![index].requestAvailable != 0) {
                    cartController
                        .getRequestResponse(
                        productId: sectionName![index].id)
                        .then((value) =>
                        AppHelperFunctions.showToast(
                            cartController
                                .requestStockResponse.value.message!));

                    // AwesomeNotificationController.showNotification();
                    return;
                  }

                  cartController
                      .getAddToCartResponse(sectionName![index].id, 1,
                      sectionName![index].preorderAvailable)
                      .then((value) =>
                  {
                    if(cartController.addToCartResponse.value.result == true){
                      cartController.cartCount.value =
                          cartController.addToCartResponse.value
                              .cartQuantity ?? 0,
                    },
                    AppHelperFunctions.showToast(cartController
                        .addToCartResponse.value.message!)
                  });
                } else {
                  Get.toNamed('/login/cart', parameters: {
                    'product_id': sectionName![index].id.toString(),
                    'product_slug' : sectionName![index].slug,
                    'sale_price' : sectionName![index].salePrice.toString(),
                    'request_available': sectionName![index].requestAvailable.toString(),
                    'preorder_available' : sectionName![index].preorderAvailable.toString()
                  });
                }
              },
              productName: sectionName![index].name!,
              ratings: sectionName![index].ratings!.toDouble(),
              reviews: sectionName![index].reviews!,
              salePrice: sectionName![index].salePrice!,
              price: sectionName![index].price!,
              imgUrl: sectionName![index].pictures![0].url!,
              isStockAvailable: sectionName![index].stock != 0,
              buttonName: sectionName![index].stock != 0
                  ? 'ADD TO CART'
                  : sectionName![index].preorderAvailable == 0
                  ? sectionName![index].requestAvailable == 0
                  ? 'OUT OF STOCK'
                  : "REQUEST FOR STOCK"
                  : 'PREORDER NOW',
              backgroundColor: sectionName![index].stock != 0
                  ? AppColors.secondary
                  : sectionName![index].preorderAvailable == 0
                  ? sectionName![index].requestAvailable == 0
                  ? AppColors.primary
                  : AppColors.request
                  : AppColors.preorder,
              isNetworkImage: true,
              isDiscountAvailable: sectionName![index].discount != 0,
              discount: sectionName![index].discount!,
              buttonColor: AppColors.white,
            )));
  }
}
