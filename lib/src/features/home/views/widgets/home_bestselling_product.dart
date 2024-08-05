// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:kirei/src/features/authentication/views/log_in/view/login.dart';
// import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
// import 'package:kirei/src/features/cart/repositories/cart_repositories.dart';
// import 'package:kirei/src/features/details/view/details.dart';
// import 'package:kirei/src/utils/helpers/helper_functions.dart';
// import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
// import 'package:kirei/src/utils/local_storage/storage_utility.dart';
// import '../../../../common/layouts/listview_layout/listview_layout.dart';
// import '../../../../common/styles/skeleton_style.dart';
// import '../../../../common/widgets/containers/vertical_product_card.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../controller/home_controller.dart';
//
// class AppHomeBestSellingProduct extends StatelessWidget {
//   const AppHomeBestSellingProduct({
//     super.key,
//     this.sectionName,
//   });
//
//   final List? sectionName;
//
//   @override
//   Widget build(BuildContext context) {
//     final homeController = HomeController.instance;
//     return SizedBox(
//         height: sectionName == null ? 170 : 265,
//         child: AppListViewLayout(
//             isScrollVertically: false,
//             itemCount: sectionName == null ? 5 : sectionName!.length,
//             builderFunction: (context, index) => sectionName == null
//                 ? ShimmerHelper().buildBasicShimmer(width: 150)
//                 : AppVerticalProductCard(
//                     //height: height,
//                     width: 150,
//                     onTap: () {
//                       Get.to(() => DetailsPage(
//                             productSlug: sectionName![index].slug!,
//                           ));
//                     },
//                     onCartTap: () {
//                       if(AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null){
//                      homeController.getAddToCartResponse(
//                          sectionName![index].id,
//                          1,
//                          sectionName![index].preorderAvailable).then((value) => AppHelperFunctions.showToast(homeController.addToCartResponse.value.message!));
//
//                      print('After login ' + AppLocalStorage().readData(LocalStorageKeys.userId).toString());
//                       }else{
//                         Get.to(()=> LogIn());
//                       }
//                     },
//                     productName: sectionName![index].name!,
//                     ratings: sectionName![index].ratings!.toDouble(),
//                     reviews: sectionName![index].reviews!,
//                     salePrice: sectionName![index].salePrice!,
//                     price: sectionName![index].price!,
//                     imgUrl: sectionName![index].pictures![0].url!,
//                     isStockAvailable: sectionName![index].stock != 0,
//                     buttonName: sectionName![index].preorderAvailable == 0
//                         ? sectionName![index].stock != 0
//                             ? 'ADD TO CART'
//                             : 'OUT OF STOCK'
//                         : 'PREORDER',
//                     backgroundColor: sectionName![index].preorderAvailable == 0
//                         ? sectionName![index].stock != 0
//                             ? AppColors.secondary
//                             : AppColors.primary
//                         : AppColors.preorder,
//                     isNetworkImage: true,
//                     isDiscountAvailable: sectionName![index].discount != 0,
//                     discount: sectionName![index].discount!,
//                   )));
//   }
// }
