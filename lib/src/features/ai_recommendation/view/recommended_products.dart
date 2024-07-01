import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/containers/vertical_product_card.dart';
import 'package:kirei/src/features/ai_recommendation/controller/recommendation_controller.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    RecommendationController recommendationController =
        Get.put(RecommendationController());
    return AppLayoutWithBackButton(
        padding: AppSizes.sm,
        title: Text(
          'Ai Recommendation',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: Colors.blueGrey),
        ),
        centerTitle: true,
        leadingIconColor: AppColors.darkGrey,
        leadingOnPress: (){
          Get.offAll(()=> const HelloConvexAppBar());
        },
        body: Obx(() {
          return recommendationController.apiHitting.value
              ? ShimmerHelper().buildProductGridShimmer()
              : AppLayoutWithRefresher(
                  onRefresh: recommendationController.onRefresh,
                  children: [
                      Column(
                          children: recommendationController
                              .productResponse.value.data!
                              .map((productData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productData.type!,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Gap(AppSizes.sm),
                            SizedBox(
                                height: 270,
                                child: AppListViewLayout(
                                  isScrollVertically: false,
                                  itemCount: productData.products!.length,
                                  builderFunction: (context, index) {
                                    final product =
                                        productData.products![index];
                                    return AppVerticalProductCard(
                                        height: 150,
                                        width: 150,
                                        imgUrl: product.pictures![0].url ?? '',
                                        onTap: () {},
                                        onCartTap: () {},
                                        productName: product.name!,
                                        ratings:
                                            double.parse("${product.ratings}"),
                                        reviews: product.reviews!,
                                        salePrice: product.salePrice!,
                                        price: product.price!,
                                        buttonName: product.stock != 0
                                            ? "ADD TO CART"
                                            : product.preorderAvailable != 0
                                                ? "PREORDER NOW"
                                                : product.requestAvailable != 0
                                                    ? "REQUEST STOCK"
                                                    : "OUT OF STOCK",
                                        backgroundColor: product.stock != 0
                                            ? AppColors.addToCartButton
                                            : product.preorderAvailable != 0
                                                ? AppColors.preorder
                                                : product.requestAvailable != 0
                                                    ? AppColors.request
                                                    : AppColors.primary,
                                        isNetworkImage: true,
                                        isDiscountAvailable:
                                            product.salePrice != product.price,
                                        discount: product.discount!,
                                        buttonColor: AppColors.white,
                                        isStockAvailable: true);
                                  },
                                )),
                            const Gap(AppSizes.spaceBtwItems)
                          ],
                        );
                      }).toList())
                    ]);
        }));
  }
}
