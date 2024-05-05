import 'package:flutter/material.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import 'card_container.dart';
import 'course_title_container.dart';
import 'product_image.dart';

class AppVerticalCourseCard extends StatelessWidget {
  const AppVerticalCourseCard({super.key, required this.onTap});

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return  AppCardContainer(
      height: AppSizes.productItemHeight,
      onTap: onTap,
      child: const AppProductImage(imgUrl: AppImages.productImage4, fit: BoxFit.fill, ),

    );
  }
}

