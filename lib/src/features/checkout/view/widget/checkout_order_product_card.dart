import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/cart/model/cart_local_model.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class AppCheckoutOrderProductsCard extends StatelessWidget {
  const AppCheckoutOrderProductsCard({super.key, required this.productsList});

  final List<CartItemLocal> productsList;

  @override
  Widget build(BuildContext context) {
    return AppListViewLayout(
        itemCount: productsList.length,
        builderFunction: (context, index) {
          return AppCardContainer(
            height: 100,
              padding: const EdgeInsets.all(AppSizes.md),
              backgroundColor: AppColors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppBannerImage(
                          width: 70,
                          isNetworkImage:
                              productsList[index].productThumbnailImage != null,
                          imgUrl: productsList[index].productThumbnailImage ??
                              AppImages.placeholder),
                      const Gap(AppSizes.spaceBtwDefaultItems),
                      SizedBox(
                        width: AppHelperFunctions.screenWidth() * .45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${productsList[index].productName}',
                              style:
                                  const TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                            const Gap(AppSizes.sm),
                            Text(
                              '${productsList[index].quantity} x ৳${productsList[index].price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(color: AppColors.darkGrey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '৳${productsList[index].price}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: AppColors.primary),
                  )
                ],
              ));
        });
  }
}
