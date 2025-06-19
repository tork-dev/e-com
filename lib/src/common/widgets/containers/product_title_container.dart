import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'card_container.dart';

class AppCourseTitleContainer extends StatelessWidget {
  const AppCourseTitleContainer({
    super.key,
    this.height,
    this.width,
    required this.onTap,
    required this.productName,
    required this.ratings,
    required this.reviews,
    required this.salePrice,
    required this.onCartPress,
    required this.buttonBackgroundColor,
    required this.buttonTextColor,
    required this.buttonName,
    required this.price});

  final double? height, width;
  final String productName, buttonName;
  final double ratings;
  final int reviews, salePrice, price;
  final VoidCallback onTap, onCartPress;
  final Color buttonBackgroundColor, buttonTextColor;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AppCardContainer(
        height: height,
          width: width,
          onTap: onTap,
          applyRadius: false,
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          //backgroundColor: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: Text(
                  productName,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              //Gap(AppSizes.spaceBtwRowItem),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar(
                    itemSize: 12.0,
                    ignoreGestures: true,
                    initialRating: ratings.toDouble(),
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
                  Gap(AppSizes.xs),
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
              Row (
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
              ),
              const Gap(AppSizes.sm),
              InkWell(
                onTap: onCartPress,
                child: AppCardContainer(
                  applyRadius: true,
                  borderRadius: AppSizes.borderRadiusSm,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.spaceBtwDefaultItems, vertical: AppSizes.xs),
                  backgroundColor: buttonBackgroundColor,
                  hasBorder: true,
                  borderColor: buttonBackgroundColor,
                  borderWidth: 1,
                  child: Text(buttonName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: buttonTextColor)
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

