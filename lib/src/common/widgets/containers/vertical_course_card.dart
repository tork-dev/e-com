import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import 'card_container.dart';
import 'course_title_container.dart';
import 'product_image.dart';

class AppVerticalCourseCard extends StatelessWidget {
  const AppVerticalCourseCard({
    super.key,
    required this.imgUrl,
    required this.onTap,
    required this.onCartTap,
    required this.productName,
    required this.ratings,
    required this.reviews,
    required this.salePrice,
    required this.price,
    required this.buttonName,
    required this.backgroundColor,
    required this.isNetworkImage,
  });

  final VoidCallback onTap, onCartTap;
  final String productName,
      ratings,
      reviews,
      salePrice,
      price,
      imgUrl,
      buttonName;
  final Color backgroundColor;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        // height: AppSizes.productItemHeight,
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppProductImage(
              onPress: onTap,
              onCartPress: onCartTap,
              isNetworkImage: isNetworkImage,
              imgUrl: imgUrl,
              buttonName: buttonName,
              backgroundColor: backgroundColor,
              fit: BoxFit.fill,
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
