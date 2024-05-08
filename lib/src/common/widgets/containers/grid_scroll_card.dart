import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/vertical_product_card.dart';
import 'package:torganic/src/utils/constants/colors.dart';

import '../../../utils/constants/image_strings.dart';
import '../../layouts/gridview_layout/gridview_layout.dart';
import 'card_container.dart';
import 'course_title_container.dart';
import 'product_image.dart';

class AppGridScrollCard extends StatelessWidget {
  const AppGridScrollCard({required this.onTap, this.itemCount = 10, super.key});

  final int itemCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return  AppGridViewLayout(
      itemCount: itemCount,
      child: AppVerticalProductCard(
        onTap: () {  },
        onCartTap: () {  },
        productName: 'NIVEA UV SUPER WATER GEL',
        ratings: 5,
        imgUrl: 'https://app.kireibd.com/storage/all/Kumano-Yushi-Deve-Deep-Cleansing-Oil-180ml.jpg',
        reviews: 5,
        salePrice: 2120,
        price: 2500,
        buttonName: 'ADD TO CART',
        backgroundColor: AppColors.error,
        isDiscountAvailable: true,
        isNetworkImage: true,
        discount: 5,

      )
    );
  }
}

