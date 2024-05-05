import 'package:flutter/material.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import 'card_container.dart';
import 'course_title_container.dart';
import 'product_image.dart';

class AppHorizontalCourseCard extends StatelessWidget {
  const AppHorizontalCourseCard({required this.onTap,super.key});

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      onTap: onTap,
      applyRadius: false,
      child: const Row(
        children: [
        ],
      ),
    );
  }
}

