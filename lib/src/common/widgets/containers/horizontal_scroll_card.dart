// import 'package:flutter/material.dart';
// import 'package:torganic/src/common/widgets/containers/product_image.dart';
// import 'package:torganic/src/common/widgets/containers/vertical_product_card.dart';
// import 'package:torganic/src/utils/constants/colors.dart';
// import '../../layouts/listview_layout/listview_layout.dart';
//
// class AppHorizontalScrollProduct extends StatelessWidget {
//   const AppHorizontalScrollProduct(
//       {required this.onTap,
//       required this.onCartTap,
//       required this.itemCount,
//       super.key,
//       required this.productName,
//       required this.ratings,
//       required this.reviews,
//       required this.salePrice,
//       required this.price,
//       required this.imgUrl,
//       this.buttonName = "ADD TO CART",
//       this.backgroundColor = AppColors.addToCartButton,
//       this.isNetworkImage = true,
//       required this.isDiscountAvailable,
//       required this.discount,
//        this.height,
//        this.width});
//
//   final VoidCallback onTap, onCartTap;
//   final int itemCount;
//   final String productName, imgUrl, buttonName;
//   final int reviews, salePrice, price;
//   final double ratings;
//   final Color backgroundColor;
//   final bool isNetworkImage, isDiscountAvailable;
//   final int discount;
//   final double? height, width;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 265,
//       child: AppListViewLayout(
//           isScrollVertically: false,
//           itemCount: itemCount,
//           builderFunction: (context, index) => AppVerticalProductCard(
//                 height: height,
//                 width: width,
//                 onTap: onTap,
//                 onCartTap: onCartTap,
//                 productName: productName,
//                 ratings: ratings,
//                 reviews: reviews,
//                 salePrice: salePrice,
//                 price: price,
//                 imgUrl: imgUrl,
//                 buttonName: buttonName,
//                 backgroundColor: backgroundColor,
//                 isNetworkImage: isNetworkImage,
//                 isStockAvailable: true,
//                 isDiscountAvailable: isDiscountAvailable,
//                 discount: discount,
//               )),
//     );
//   }
// }
