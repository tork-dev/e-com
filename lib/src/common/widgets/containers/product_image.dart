import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/common/styles/spacing_style.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AppProductImage extends StatelessWidget {
  const AppProductImage({
    this.height,
    this.width,
    this.border,
    required this.onPress,
    required this.onCartPress,
    required this.imgUrl,
    this.fit = BoxFit.contain,
    this.boarderRadius = AppSizes.md,
    required this.isNetworkImage,
    required this.buttonName,
    required this.backgroundColor,
    required this.isDiscountAvailable,
    required this.discount,
    super.key,
    required this.isStockAvailable,
  });

  final double? height, width;
  final String imgUrl, buttonName;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final bool isNetworkImage, isDiscountAvailable, isStockAvailable;
  final double? boarderRadius;
  final VoidCallback onPress, onCartPress;
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
                AppCardContainer(
                  width: 150,
                  height: 145,
                  applyRadius: false,
                  //backgroundColor: Colors.red,
                  child: ClipRRect(
                      child: Image(
                    image: isNetworkImage
                        ? NetworkImage(imgUrl)
                        : AssetImage(imgUrl) as ImageProvider,
                    fit: BoxFit.fill,
                  )),
                ),
                Visibility(
                  visible: isDiscountAvailable,
                  child: Positioned(
                    left: 10,
                    top: 10,
                    child: AppCardContainer(
                        height: 32,
                        width: 32,
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
          const Gap(AppSizes.sm),
          InkWell(
            onTap: onCartPress,
            child: AppCardContainer(
              applyRadius: false,
              height: 40,
              backgroundColor: backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isStockAvailable,
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 17,
                      color: AppColors.white,
                    ),
                  ),
                  Text(' $buttonName',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: AppColors.white))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
