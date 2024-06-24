import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:torganic/src/common/styles/skeleton_style.dart';
import 'package:torganic/src/common/widgets/buttons/app_buttons.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/features/review/controller/review_controller.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/colors.dart';

class AppReviewPostCard extends StatelessWidget {
  const AppReviewPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ReviewController.instance;
    return Obx(() {
        return controller.apiHitting.value? ShimmerHelper().buildBasicShimmer(height: 150) : AppCardContainer(
           width: AppHelperFunctions.screenWidth(),
            padding: const EdgeInsets.all(AppSizes.sm),
            backgroundColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child:
                      RatingBar.builder(
                        itemSize: 20.0,
                        initialRating: controller.givenRating.value,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        glowColor: Colors.amber,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) {
                          return const Icon(Icons.star, color: Colors.amber);
                        },
                        onRatingUpdate: (rating) {
                          controller.givenRating.value = rating;
                        },
                      )

                ),
                const Gap(AppSizes.sm),
                const Text('Enter Name*'),
                const Gap(AppSizes.xs),
                SizedBox(
                  height: 50,
                  width: (MediaQuery.of(context).size.width - 32) * (4 / 5),
                  child: TextFormField(
                    cursorColor: AppColors.primary,
                    controller: controller.nameController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(251, 251, 251, 1),
                        hintText: "Type your name here",
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: AppColors.lightGrey),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.lightGrey, width: 0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(35.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.lightGrey, width: 0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(35.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0)),
                  ),
                ),
                const Gap(AppSizes.sm),
                const Text('Your review*'),
                const Gap(AppSizes.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 80,
                      width: (MediaQuery.of(context).size.width - 32) * (4 / 5),
                      child: TextFormField(
                        cursorColor: AppColors.primary,
                        controller: controller.commentController,
                        expands: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(251, 251, 251, 1),
                            //isCollapsed: userName == true ? true : false,
                            isCollapsed:  true,
                            hintText: 'Type your review here...',
                            hintStyle:
                            TextStyle(fontSize: 14.0, color: AppColors.lightGrey),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColors.lightGrey, width: 0.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(35.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColors.lightGrey, width: 0.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(35.0),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8)),
                      ),
                    ),
                    AppButtons.smallRoundButton(
                        onPressed: (){
                          print(controller.submitReview());
                        },
                        buttonColor: AppColors.primary,
                        buttonChild: const Icon(Icons.send))
                  ],
                ),
              ],
            )
        );
      }
    );
  }
}
