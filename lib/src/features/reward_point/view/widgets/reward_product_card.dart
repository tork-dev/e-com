import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/widgets/containers/banner_image.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/point_redeem_controller.dart';

class RewardProductCard extends StatelessWidget {
  const RewardProductCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final products = PointRedeemController.instance;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCardContainer(
              backgroundColor: AppColors.addToCartButton,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AppBannerImage(
                    height: 150,
                    width: double.infinity,
                    isNetworkImage: true,
                    imgUrl: products.pointRedemptionResponse.value.data![index]
                        .product!.thumbnailImage,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 0,
                    right: 0,
                    child: AppCardContainer(
                      applyRadius: false,
                      height: 40,
                      // Use double.infinity for full width
                      width: double.infinity,
                      backgroundColor: AppColors.addToCartButton,
                      child: Center(
                        child: Text(
                          'Shop now'.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSizes.md),
                Text(
                  products.pointRedemptionResponse.value.data![index]
                      .product!.productCategories!
                      .map((category) => category.name)
                      .where((name) => name != null && name!.isNotEmpty)
                      .join(', '),
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis, // No ellipsis, text will wrap naturally
                ),
            Text(
              products
                  .pointRedemptionResponse.value.data![index].product!.name!,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,
            ),
            const Gap(AppSizes.md),
            Text(
                '${products.pointRedemptionResponse.value.data![index]
                    .purchasePoint!} points required'),
          ],
        ),
        Visibility(
          visible:
          products.pointRedemptionResponse.value.data![index].isUnlocked !=
              1,
          child: AppCardContainer(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              applyRadius: false,
              height: double.infinity,
              width: double.infinity,
              backgroundColor: AppColors.grey.withOpacity(.9),
              child: Center(
                  child: Text(
                      textAlign: TextAlign.center,
                      'It is allowed to shop only for ${products
                          .pointRedemptionResponse.value.data![index]
                          .membershipTitle} Members'))),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: AppCardContainer(
            applyRadius: false,
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.sm, vertical: AppSizes.xs),
            backgroundColor: products.pointRedemptionResponse.value.data![index]
                .membershipId ==
                1
                ? AppColors.grey
                : products.pointRedemptionResponse.value.data![index]
                .membershipId ==
                2
                ? AppColors.gold
                : AppColors.platinum,
            child: Text(products
                .pointRedemptionResponse.value.data![index].membershipTitle!),
          ),
        ),
      ],
    );
  }
}
