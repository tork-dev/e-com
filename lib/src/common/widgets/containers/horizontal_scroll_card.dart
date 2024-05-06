import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/product_image.dart';
import 'package:torganic/src/common/widgets/containers/vertical_course_card.dart';
import '../../layouts/listview_layout/listview_layout.dart';

class AppHorizontalScrollProduct extends StatelessWidget {
  const AppHorizontalScrollProduct(
      {required this.onTap,
      required this.itemCount,
      super.key,
      required this.productName,
      required this.ratings,
      required this.reviews,
      required this.salePrice,
      required this.price,
      required this.imgUrl});

  final VoidCallback onTap;
  final int itemCount;
  final String productName, ratings, reviews, salePrice, price, imgUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      //width: 150,
      child: AppListViewLayout(
          isScrollVertically: false,
          itemCount: itemCount,
          builderFunction: (context, index) => AppVerticalCourseCard(
              onTap: onTap,
              productName: productName,
              ratings: ratings,
              reviews: reviews,
              salePrice: salePrice,
              price: price,
              imgUrl: imgUrl)),
    );
  }
}
