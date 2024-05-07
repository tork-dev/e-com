import 'package:flutter/material.dart';
import '../../../../common/widgets/containers/horizontal_scroll_card.dart';
import '../../../../utils/constants/image_strings.dart';

class AppHomeProductCard extends StatelessWidget {
  const AppHomeProductCard({
    super.key,
  });
  final int discount = 30;

  @override
  Widget build(BuildContext context) {
    return AppHorizontalScrollProduct(
      onTap: () {},
      onCartTap: () {},
      itemCount: 5,
      isNetworkImage: true,
      imgUrl: 'https://app.kireibd.com//storage//all//Rohto-Melano-CC-Brightening-Gel.png',
      productName: 'Skin Aqua super Moisture Gel',
      price: 1450,
      ratings: 4,
      reviews: 41,
      salePrice: 1500,
      isDiscountAvailable: discount != 0,
      discount: discount,
    );
  }
}