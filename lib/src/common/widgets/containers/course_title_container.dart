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
    required this.price});

  final double? height, width;
  final String productName, ratings, reviews, salePrice, price;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AppCardContainer(
        height: height,
          width: width,
          onTap: onTap,
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          //backgroundColor: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                productName,
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              //Gap(AppSizes.spaceBtwRowItem),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar(
                    itemSize: 12.0,
                    ignoreGestures: true,
                    initialRating: double.parse(ratings),
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: Icon(Icons.star,
                          color: Color.fromRGBO(192, 53, 50, 1)),
                      empty: Icon(Icons.star,
                          color: Color.fromRGBO(224, 224, 225, 1)),
                      half: Icon(Icons.star,
                          color: Color.fromRGBO(192, 53, 50, 1)),
                    ),
                    itemPadding: EdgeInsets.only(right: 1.0),
                    onRatingUpdate: (rating) {
                      //print(rating);
                    },
                  ),
                  Text(
                    "(${reviews})",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
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
                          "৳" + price,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.dark_grey,
                              fontSize: 9,
                              fontWeight: FontWeight.w600),
                        ),
                        Gap(AppSizes.sm)
                      ],
                    ),
                  ),

                  Text(
                    "৳" + salePrice,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

