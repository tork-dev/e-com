import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/containers/vertical_product_card.dart';
import 'package:torganic/src/features/shop/controller/shop_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';

import '../../../../common/layouts/gridview_layout/gridview_layout.dart';

class AppShopGridScrollCard extends StatelessWidget {
  const AppShopGridScrollCard({super.key});

  @override
  Widget build(BuildContext context) {
    final shopController = ShopController.instance;
    return Obx(() {
     // print('shop data ${shopController.shopPageProduct.value.data!.length}');
      return AppGridViewLayout(
          itemCount: shopController.shopPageProduct.value.result == null
              ? 10
              : shopController.shopPageProduct.value.data!.length,
          builderFunction: (context, index) => shopController.shopPageProduct.value.result == null?
              ShimmerHelper().buildBasicShimmer(
                height: 150,
                width: 150
              ) :
              AppVerticalProductCard(
                onTap: () {},
                onCartTap: () {},
                productName: shopController.shopPageProduct.value.data![index].name ?? '',
                ratings: shopController.shopPageProduct.value.data![index].ratings!.toDouble(),
                imgUrl:
                shopController.shopPageProduct.value.data![index].pictures![0].url ?? '',
                reviews: shopController.shopPageProduct.value.data![index].reviews ?? 0,
                salePrice: shopController.shopPageProduct.value.data![index].salePrice ?? 0,
                price: shopController.shopPageProduct.value.data![index].price ?? 0,
                buttonName: shopController.shopPageProduct.value.data![index].preorderAvailable == 0 ?
                shopController.shopPageProduct.value.data![index].stock !=0? 'ADD TO CART' : "OUT OF STOCK" : 'PREORDER',
                backgroundColor: shopController.shopPageProduct.value.data![index].preorderAvailable == 0 ?
                shopController.shopPageProduct.value.data![index].stock !=0? AppColors.secondary : AppColors.primary : AppColors.preorder,
                isDiscountAvailable: shopController.shopPageProduct.value.data![index].salePrice != shopController.shopPageProduct.value.data![index].price,
                isNetworkImage: true,
                discount: shopController.shopPageProduct.value.data![index].discount ?? 0,
                isStockAvailable: shopController.shopPageProduct.value.data![index].stock != 0,
              )
      );
    });
  }
}
