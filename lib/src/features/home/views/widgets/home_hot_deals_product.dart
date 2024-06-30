// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kirei/src/features/details/view/details.dart';
// import '../../../../common/layouts/listview_layout/listview_layout.dart';
// import '../../../../common/styles/skeleton_style.dart';
// import '../../../../common/widgets/containers/vertical_product_card.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../controller/home_controller.dart';
//
// class AppHomeHotDealsProduct extends StatelessWidget {
//   const AppHomeHotDealsProduct({
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
//                   .featuredProducts!.length,
//               builderFunction: (context, index) => homeController
//                   .homeProductResponse.value.success ==
//                   null
//                   ? ShimmerHelper().buildBasicShimmer(width: 150)
//                   : AppVerticalProductCard(
//                 //height: height,
//                 width: 150,
//                 onTap: () {
//                   Get.to(()=> DetailsPage(productSlug: homeController.homeProductResponse.value.featuredProducts![index].id!));
//                 },
//                 onCartTap: () {},
//                 productName: homeController.homeProductResponse.value
//                     .featuredProducts![index].name ??
//                     'name',
//                 ratings: homeController.homeProductResponse.value
//                     .featuredProducts![index].ratings!.toDouble(),
//                 reviews: homeController.homeProductResponse.value
//                     .featuredProducts![index].reviews!,
//                 salePrice: homeController.homeProductResponse.value
//                     .featuredProducts![index].salePrice!,
//                 price: homeController.homeProductResponse.value
//                     .featuredProducts![index].price!,
//                 imgUrl: homeController.homeProductResponse.value
//                     .featuredProducts![index].pictures![0].url!,
//                 isStockAvailable: homeController.homeProductResponse.value
//                     .featuredProducts![index].stock !=
//                     0,
//                 buttonName: homeController.homeProductResponse.value
//                     .featuredProducts![index].stock !=
//                     0
//                     ? 'ADD TO CART'
//                     : 'OUT OF STOCK',
//                 backgroundColor: homeController.homeProductResponse.value
//                     .featuredProducts![index].stock !=
//                     0
//                     ? AppColors.secondary
//                     : AppColors.primary,
//                 isNetworkImage: true,
//                 isDiscountAvailable: homeController.homeProductResponse
//                     .value.featuredProducts![index].discount !=
//                     0,
//                 discount: homeController.homeProductResponse.value
//                     .featuredProducts![index].discount!,
//               )));
//     });
//   }
// }
