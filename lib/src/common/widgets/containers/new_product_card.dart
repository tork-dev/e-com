import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/common/styles/spacing_style.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AppNewProductCard extends StatelessWidget {
  const AppNewProductCard({
    this.height,
    this.width,
    this.border,
    this.imgHeight,
    this.imgWidth,
    required this.productName,
    required this.categoryLength,
    required this.categoryName,
    required this.buttonColor,
    required this.onPress,
    required this.onCartPress,
    required this.imgUrl,
    this.fit = BoxFit.contain,
    this.boarderRadius = AppSizes.md,
    required this.buttonName,
    required this.backgroundColor,
    required this.isDiscountAvailable,
    required this.discount,
    required this.ratings,
    required this.reviews,
    required this.price,
    required this.salePrice,
    super.key,
    required this.isStockAvailable,
  });

  final double? height, width, imgHeight, imgWidth;
  final String imgUrl, buttonName, productName, salePrice, price;
  final List<dynamic> categoryName;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final bool isDiscountAvailable, isStockAvailable;
  final double? boarderRadius, ratings;
  final VoidCallback onPress, onCartPress;
  final int? discount, categoryLength, reviews;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      height: height,
      width: width,
      backgroundColor: AppColors.addToCartButton,
      applyRadius: false,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(AppSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onPress,
            child: Stack(
              children: [
                Center(
                  child: AppBannerImage(
                      applyImageRadius: false,
                      isNetworkImage: true,
                      imgUrl: imgUrl),
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
          // const Gap(AppSizes.sm),
          AppCardContainer(
            onTap: onCartPress,
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
                        .apply(color: buttonColor))
              ],
            ),
          ),
          const Gap(AppSizes.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Aligns text to the start
            children: List.generate(
              categoryLength!,
              (categoryIndex) {
                final name = categoryName[categoryIndex];
                return Text(
                  "$name, ",
                  style: Theme.of(context).textTheme.labelSmall,
                );
              },
            ),
          ),
          Text(
            productName,
            style: Theme.of(context).textTheme.labelLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(AppSizes.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBar(
                itemSize: 12.0,
                ignoreGestures: true,
                initialRating: ratings!.toDouble(),
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const Icon(Icons.star,
                      color: Color.fromRGBO(192, 53, 50, 1)),
                  empty: const Icon(Icons.star,
                      color: Color.fromRGBO(224, 224, 225, 1)),
                  half: const Icon(Icons.star,
                      color: Color.fromRGBO(192, 53, 50, 1)),
                ),
                itemPadding: const EdgeInsets.only(right: 1.0),
                onRatingUpdate: (rating) {
                  //print(rating);
                },
              ),
              Text(
                "($reviews)",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: salePrice != price,
                child: Row(
                  children: [
                    Text(
                      "৳$price",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.darkGrey,
                          fontSize: 9,
                          fontWeight: FontWeight.w600),
                    ),
                    const Gap(AppSizes.sm)
                  ],
                ),
              ),

              Text(
                "৳$salePrice",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
