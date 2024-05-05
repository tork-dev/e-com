import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/horizontal_course_card.dart';
import 'package:torganic/src/common/widgets/containers/horizontal_scroll_card.dart';
import 'package:torganic/src/common/widgets/containers/vertical_course_card.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../layouts/listview_layout/listview_layout.dart';
import 'card_container.dart';
import 'course_title_container.dart';
import 'product_image.dart';

class AppVerticalScrollCard extends StatelessWidget {
  const AppVerticalScrollCard({required this.onTap, super.key});

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 200,
      child: AppListViewLayout(
          isScrollVertically: true,
          itemCount: 5,
          builderFunction: (BuildContext context, int index) => AppHorizontalCourseCard(
              onTap: onTap,
            ),
           ),
    );
  }
}