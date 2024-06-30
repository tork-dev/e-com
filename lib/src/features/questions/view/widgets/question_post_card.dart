import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/questions/controller/question_controller.dart';
import 'package:kirei/src/features/review/controller/review_controller.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/colors.dart';

class AppQuestionPostCard extends StatelessWidget {
  const AppQuestionPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = QuestionController.instance;
      return AppCardContainer(
          width: AppHelperFunctions.screenWidth(),
          padding: const EdgeInsets.all(AppSizes.md),
          backgroundColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(AppSizes.sm),
              SizedBox(
                height: 40,
                width: (MediaQuery.of(context).size.width - 32) * (4 / 5),
                child: TextFormField(
                  cursorColor: AppColors.primary,
                  controller: controller.nameController,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.grey,
                      //isCollapsed: userName == true ? true : false,
                      isCollapsed:  true,
                      hintText: 'Type your name',
                      hintStyle:
                      TextStyle(fontSize: 14.0, color: AppColors.darkGrey),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.lightGrey, width: 0.5),
                        // borderRadius: BorderRadius.all(
                        //   Radius.circular(35.0),
                        // ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.lightGrey, width: 0.5),
                        // borderRadius: BorderRadius.all(
                        //   Radius.circular(35.0),
                        // ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8)
                  ),
                ),
              ),
              const Gap(AppSizes.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: (MediaQuery.of(context).size.width - 32) * (4 / 5),
                    child: TextFormField(
                      cursorColor: AppColors.primary,
                     controller: controller.questionController,
                      expands: true,
                      maxLines: null,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColors.grey,
                          //isCollapsed: userName == true ? true : false,
                          isCollapsed:  true,
                          hintText: 'Type your question here...',
                          hintStyle:
                          TextStyle(fontSize: 14.0, color: AppColors.darkGrey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.lightGrey, width: 0.5),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColors.lightGrey, width: 0.5),

                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8)
                      ),
                    ),
                  ),
                  AppButtons.smallRoundButton(
                      onPressed: (){
                        //print(controller.submitReview());
                        controller.submitQuestion();
                      },
                      buttonColor: AppColors.primary,
                      buttonChild: const Icon(Icons.send))
                ],
              ),
            ],
          )
      );
    }

}
