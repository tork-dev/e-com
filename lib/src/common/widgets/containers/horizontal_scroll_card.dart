import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/product_image.dart';
import 'package:torganic/src/common/widgets/containers/vertical_course_card.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import '../../layouts/listview_layout/listview_layout.dart';

class AppHorizontalScrollProduct extends StatelessWidget {
  const AppHorizontalScrollProduct(
      {required this.onTap,
      required this.onCartTap,
      required this.itemCount,
      super.key,
      required this.productName,
      required this.ratings,
      required this.reviews,
      required this.salePrice,
      required this.price,
      required this.imgUrl,
      this.buttonName = "ADD TO CART",
      this.backgroundColor = AppColors.addToCartButton,
      this.isNetworkImage = true,
      required this.isDiscountAvailable,
      required this.discount});

  final VoidCallback onTap, onCartTap;
  final int itemCount;
  final String productName,imgUrl, buttonName;
  final int ratings,
      reviews,
      salePrice,
      price;
  final Color backgroundColor;
  final bool isNetworkImage, isDiscountAvailable;
  final int discount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265,
      //width: 150,
      child: AppListViewLayout(
          isScrollVertically: false,
          itemCount: itemCount,
          builderFunction: (context, index) => AppVerticalCourseCard(
                onTap: onTap,
                onCartTap: onCartTap,
                productName: productName,
                ratings: ratings,
                reviews: reviews,
                salePrice: salePrice,
                price: price,
                imgUrl: imgUrl,
                buttonName: buttonName,
                backgroundColor: backgroundColor,
                isNetworkImage: isNetworkImage,
                isDiscountAvailable: isDiscountAvailable,
                discount: discount,
              )),
    );
  }
}
