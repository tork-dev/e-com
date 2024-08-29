import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'card_container.dart';
import 'course_title_container.dart';
import 'product_image.dart';

class AppVerticalProductCard extends StatelessWidget {
  const AppVerticalProductCard({
    super.key,
    required this.imgUrl,
    required this.onTap,
     required this.onCartTap  ,
    required this.productName,
    required this.ratings,
    required this.reviews,
    required this.salePrice,
    required this.price,
    required this.buttonName,
    required this.backgroundColor,
    this.isNetworkImage = true,
    required this.isDiscountAvailable,
    required this.discount,
     this.height,
     this.width,
    this.padding,
    this.margin,
    this.imgHeight,
    this.imgWidth,
    required this.buttonColor,
    required this.isStockAvailable
  });

  final VoidCallback onTap, onCartTap;
  final String productName, imgUrl, buttonName;
  final double ratings;
  final int reviews,
      salePrice,
      price;
  final Color? backgroundColor, buttonColor;
  final bool isNetworkImage, isDiscountAvailable, isStockAvailable;
  final int discount;
  final double? height, width, imgHeight, imgWidth;
  final EdgeInsetsGeometry? padding, margin;


  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        height: height,
        width: width,
        applyRadius: false,
        padding: padding,
        margin: margin,
        backgroundColor: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppProductImage(
              imgHeight: imgHeight,
              imgWidth: imgWidth,
              onPress: onTap,
              onCartPress: onCartTap,
              isNetworkImage: isNetworkImage,
              imgUrl: imgUrl,
              buttonName: buttonName,
              backgroundColor: backgroundColor,
              fit: BoxFit.fill,
              isDiscountAvailable: isDiscountAvailable,
              isStockAvailable: isStockAvailable,
              discount: discount,
              buttonColor: buttonColor!,
            ),
            AppCourseTitleContainer(
                onTap: onTap,
                productName: productName,
                ratings: ratings,
                reviews: reviews,
                salePrice: salePrice,
                price: price)
          ],
        ));
  }
}
