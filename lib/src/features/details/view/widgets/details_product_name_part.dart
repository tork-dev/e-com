import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class AppDetailsProductNamePart extends StatelessWidget {
  const AppDetailsProductNamePart({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsPageController.instance;
    return Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailsController.productDetails.value.detailedProducts == null
                ? ShimmerHelper().buildBasicShimmer(height: 30)
                : Text(
                detailsController.productDetails.value.detailedProducts!.name!,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium),
            const Gap(AppSizes.spaceBtwItems),
            detailsController.productDetails.value.detailedProducts == null
                ? ShimmerHelper().buildBasicShimmer(height: 30)
                :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      RatingBar(
                        itemSize: 18.0,
                        ignoreGestures: true,
                        initialRating: double.parse(
                            detailsController.productDetails.value.detailedProducts!
                                .ratings.toString()),
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star,
                              color: Color(0xffffe234)),
                          empty: const Icon(Icons.star,
                              color: Color.fromRGBO(224, 224, 225, 1)),
                          half: const Icon(Icons.star,
                              color: Color.fromRGBO(192, 53, 50, 1)),
                        ),
                        itemPadding: const EdgeInsets.only(right: 1.0),
                        onRatingUpdate: (double value) {},
                      ),
                      Text(
                        ' (${detailsController.productDetails.value.detailedProducts!
                            .reviews})',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: AppColors.darkGrey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      Gap(AppSizes.spaceBtwItems),
                      Icon(Icons.favorite_border)
                    ],
                  ),
                )
              ],
            ),
            
          ],
        );
      }
    );
  }
}

