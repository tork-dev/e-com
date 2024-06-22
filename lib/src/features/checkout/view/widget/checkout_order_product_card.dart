import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/containers/banner_image.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/cart/model/cart_get_response_model.dart';
import 'package:torganic/src/features/purchase_history/controller/purchase_history_details_controller.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/device/device_utility.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class AppCheckoutOrderProductsCard extends StatelessWidget {
  const AppCheckoutOrderProductsCard({super.key, required this.productsList});

  final List<CartItem> productsList;

  @override
  Widget build(BuildContext context) {
      return AppListViewLayout(
          itemCount: productsList.length,
          builderFunction: (context, index) {
            return AppCardContainer(
                applyRadius: false,
                padding: const EdgeInsets.all(AppSizes.md),
                backgroundColor: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppBannerImage(
                      width: 70,
                      isNetworkImage: true,
                        imgUrl: productsList[index].productThumbnailImage),
                    const Gap(AppSizes.spaceBtwItems),
                    SizedBox(
                      width: AppHelperFunctions.screenWidth() * .5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${productsList[index].productName}', style: const TextStyle(
                            overflow: TextOverflow.ellipsis
                          ),),
                          const Gap(AppSizes.sm),
                          Row(
                            children: [
                              Text('${productsList[index].quantity} x ৳${productsList[index].price}',
                                style: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.darkGrey),
                              ),
                            ],)
                        ],
                      ),
                    ),
                    Text('৳${productsList[index].price}',
                      style: Theme.of(context).textTheme.titleMedium!.apply(color: AppColors.primary),)
                  ],
                ));
          });

  }
}
