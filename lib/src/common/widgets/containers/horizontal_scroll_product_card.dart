import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/cart/controllers/cart_controller.dart';
import 'package:torganic/src/utils/device/device_utility.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import '../../../features/details/view/details.dart';
import '../../../utils/constants/colors.dart';
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
    return SizedBox(
        height: sectionName == null ? 170 : 265,
        child: AppListViewLayout(
            isScrollVertically: false,
            itemCount: sectionName == null ? 5 : sectionName!.length,
            builderFunction: (context, index) => sectionName == null
                ? ShimmerHelper().buildBasicShimmer(width: 150)
                : AppVerticalProductCard(
                    //height: height,
                    width: 150,
                    onTap: () {
                      Get.to(() => DetailsPage(
                            productSlug: sectionName![index].id!,
                          ));
                    },
                    onCartTap: ()=> print('working'),
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
                        : 'PREORDER',
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
