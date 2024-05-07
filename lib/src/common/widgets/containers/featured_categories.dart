import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/spacing_style.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class AppFeatureCategories extends StatelessWidget {
  const AppFeatureCategories(
      {super.key,
        required this.itemCount,
        required this.imgUrl,
        required this.categoryName});

  final int itemCount;
  final String imgUrl, categoryName;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      height: 100,
      //backgroundColor: Colors.black,
      child: AppListViewLayout(
          isScrollVertically: false,
          itemCount: itemCount,
          builderFunction: (BuildContext context, int index) => Column(
            children: [
              AppBannerImage(
                height: 70,
                width: 70,
                isNetworkImage: true,
                imgUrl: imgUrl,
              ),
              const Gap(8),
              Text(
                categoryName,
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          )),
    );
  }
}

