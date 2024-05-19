// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../common/layouts/listview_layout/listview_layout.dart';
// import '../../../../common/styles/skeleton_style.dart';
// import '../../../../common/widgets/containers/vertical_product_card.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../controller/home_controller.dart';
//
// class AppHomeNewArrivalsProduct extends StatelessWidget {
//   const AppHomeNewArrivalsProduct({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final homeController = HomeController.instance;
//     return Obx(() {
//       return SizedBox(
//           height: homeController.homeProductResponse.value.success == null
//               ? 170
//               : 265,
//           child: AppListViewLayout(
//               isScrollVertically: false,
//               itemCount:
//               homeController.homeProductResponse.value.success == null
//                   ? 5
//                   : homeController.homeProductResponse.value
//                   .newProducts!.length,
//               builderFunction: (context, index) => homeController
//                   .homeProductResponse.value.success ==
//                   null
//                   ? ShimmerHelper().buildBasicShimmer(width: 150)
//                   : AppVerticalProductCard(
//                 //height: height,
//                 width: 150,
//                 onTap: () {},
//                 onCartTap: () {},
//                 productName: homeController.homeProductResponse.value
//                     .newProducts![index].name ??
//                     'name',
//                 ratings: homeController.homeProductResponse.value
//                     .newProducts![index].ratings!.toDouble(),
//                 reviews: homeController.homeProductResponse.value
//                     .newProducts![index].reviews!,
//                 salePrice: homeController.homeProductResponse.value
//                     .newProducts![index].salePrice!,
//                 price: homeController.homeProductResponse.value
//                     .newProducts![index].price!,
//                 imgUrl: homeController.homeProductResponse.value
//                     .newProducts![index].pictures![0].url!,
//                 isStockAvailable: homeController.homeProductResponse.value
//                     .newProducts![index].stock !=
//                     0,
//                 buttonName: homeController.homeProductResponse.value
//                     .newProducts![index].stock !=
//                     0
//                     ? 'ADD TO CART'
//                     : 'OUT OF STOCK',
//                 backgroundColor: homeController.homeProductResponse.value
//                     .newProducts![index].stock !=
//                     0
//                     ? AppColors.secondary
//                     : AppColors.primary,
//                 isNetworkImage: true,
//                 isDiscountAvailable: homeController.homeProductResponse
//                     .value.newProducts![index].discount !=
//                     0,
//                 discount: homeController.homeProductResponse.value
//                     .newProducts![index].discount!,
//               )));
//     });
//   }
// }
