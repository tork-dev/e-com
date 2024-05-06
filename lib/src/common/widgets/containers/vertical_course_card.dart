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
    required this.productName,
    required this.ratings,
    required this.reviews,
    required this.salePrice,
    required this.price,
  });

  final VoidCallback onTap;
  final String productName, ratings, reviews, salePrice, price, imgUrl;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
       // height: AppSizes.productItemHeight,
      width: 150,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppProductImage(
              imgUrl: imgUrl,
              fit: BoxFit.fill,
            ),
            AppCourseTitleContainer(
                productName: productName,
                ratings: ratings,
                reviews: reviews,
                salePrice: salePrice,
                price: price)
          ],
        ));
  }
}
