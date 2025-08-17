import 'package:flutter/material.dart';
import 'package:kirei/src/common/styles/app_dividers.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AppProductImage extends StatelessWidget {
  const AppProductImage({
    this.height,
    this.width,
    this.border,
    required this.imgHeight,
    required this.imgWidth,
    required this.onPress,
    required this.imgUrl,
    this.fit = BoxFit.contain,
    this.boarderRadius = AppSizes.md,
    required this.isNetworkImage,
    required this.isDiscountAvailable,
    required this.discount,
    super.key,
    required this.isStockAvailable,
  });

  final double? height, width, imgHeight, imgWidth;
  final String imgUrl;
  final BoxBorder? border;
  final BoxFit? fit;
  final bool isNetworkImage, isDiscountAvailable, isStockAvailable;
  final double? boarderRadius;
  final VoidCallback onPress;
  final int? discount;


  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      height: height,
      width: width,
      applyRadius: false,
      //backgroundColor: Colors.black,
      child: Column(
        children: [
          InkWell(
            onTap: onPress,
            child: Stack(
              children: [
                AppBannerImage(
                    width: imgWidth,
                    height: imgHeight,
                  applyImageRadius: false,
                  isNetworkImage: true,
                    imgUrl: imgUrl,
                  fit: BoxFit.cover,
                  applyOnlyRadius: true,
                  topRightRadius: AppSizes.borderRadiusMd,
                  topLeftRadius: AppSizes.borderRadiusMd,
                ),
                Visibility(
                  visible: isDiscountAvailable,
                  child: Positioned(
                    left: 10,
                    top: 10,
                    child: AppCardContainer(
                      borderRadius: AppSizes.borderRadiusSm,
                        height: 18,
                        width: 38,
                        backgroundColor: AppColors.primary,
                        child: Center(
                            child: Text(
                          '-$discount%',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .apply(color: AppColors.light),
                        ))),
                  ),
                )
              ],
            ),
          ),
          AppDividersStyle.fullFlatAppDivider
          // const Gap(AppSizes.sm),
          // InkWell(
          //   onTap: onCartPress,
          //   child: AppCardContainer(
          //     applyRadius: false,
          //     height: 40,
          //     backgroundColor: backgroundColor,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Visibility(
          //           visible: isStockAvailable,
          //           child: const Icon(
          //             Icons.shopping_bag_outlined,
          //             size: 17,
          //             color: AppColors.white,
          //           ),
          //         ),
          //         Text(' $buttonName',
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .bodyMedium!
          //                 .apply(color: buttonColor)
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
