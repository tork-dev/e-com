import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/product_image.dart';
import '../../layouts/listview_layout/listview_layout.dart';


class AppHorizontalScrollProduct extends StatelessWidget {
  const AppHorizontalScrollProduct({
    required this.onTap,
    required this.productImage,
    super.key});

  final VoidCallback onTap;
  final String productImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: AppListViewLayout(
          isScrollVertically: false,
          itemCount: 5,
          builderFunction: (context, index) => AppProductImage(imgUrl: productImage,)),
    );
  }
}

