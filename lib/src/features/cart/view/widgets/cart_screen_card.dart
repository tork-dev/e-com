import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/features/cart/controllers/cart_controller.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class AppCartProductCard extends StatelessWidget {
  const AppCartProductCard({required this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(() {
      return AppListViewLayout(
        itemCount: cartController.allCartProducts.length == 0
            ? 5
            : cartController.allCartProducts[0].cartItems!.length,
        builderFunction: (context, index) => cartController
                    .allCartProducts.length ==
                0
            ? ShimmerHelper().buildBasicShimmer(height: 150)
            : AppCardContainer(
                onTap: onTap,
                backgroundColor: AppColors.white,
                applyRadius: false,
                padding: const EdgeInsets.all(AppSizes.sm),
                child: Row(
                  children: [
                    AppBannerImage(
                        height: 100,
                        width: 100,
                        applyImageRadius: false,
                        isNetworkImage: true,
                        imgUrl: cartController.allCartProducts[0]
                            .cartItems![index].productThumbnailImage!),
                    const Gap(AppSizes.spaceBtwRowItem),
                    AppCardContainer(
                        width: 200,
                        height: 100,
                        //backgroundColor: AppColors.secondary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartController.allCartProducts[0]
                                  .cartItems![index].productName!,
                              style: const TextStyle(fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(AppSizes.spaceBtwRowItem),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '৳${cartController.allCartProducts[0].cartItems![index].price!}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                InkWell(
                                    onTap: () {
                                      AppHelperFunctions.showAlert(
                                          onConfirm: () {
                                            cartController
                                                .getCartDelete(cartController
                                                    .allCartProducts[0]
                                                    .cartItems![index]
                                                    .id!)
                                                .then((value) {
                                              cartController
                                                  .onRefresh()
                                                  .then((value) => {
                                                        cartController.cartCount
                                                                .value =
                                                            cartController
                                                                .cartProductDeleteResponse
                                                                .value
                                                                .cartQuantity!,
                                                        Get.back(),
                                                        AppHelperFunctions
                                                            .showToast(
                                                                cartController
                                                                    .cartProductDeleteResponse
                                                                    .value
                                                                    .message!),
                                                      });
                                            });
                                          },
                                          message:
                                              'Are you sure to remove this item?',
                                          leftButtonName: 'Cancel',
                                          rightButtonName: 'Confirm',
                                          buttonColor: AppColors.primary);
                                    },
                                    child: const Icon(
                                        Icons.delete_forever_outlined))
                              ],
                            )
                          ],
                        )),
                    const Gap(AppSizes.spaceBtwSections),
                     AppCardContainer(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.add),
                            AppCardContainer(
                                height: 25,
                                width: 25,
                                applyRadius: false,
                                borderWidth: 1,
                                hasBorder: true,
                                borderColor: AppColors.secondary,
                                child: Center(child: Text(cartController.allCartProducts[0].cartItems![index].quantity!.toString()))),
                            const Icon(Icons.remove),
                          ],
                        ))
                  ],
                ),
              ),
      );
    });
  }
}
