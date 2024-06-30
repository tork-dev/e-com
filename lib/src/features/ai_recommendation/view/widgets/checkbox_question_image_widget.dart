import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/recommendation_controller.dart';

class CheckBoxQuestionImageWidget extends StatelessWidget {
  final String question;
  final List option, images;

  const CheckBoxQuestionImageWidget(
      {super.key,
        required this.question,
        required this.option,
        required this.images});

  @override
  Widget build(BuildContext context) {
    final recommendationController = RecommendationController.instance;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          question,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSizes.md),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 185
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: option.length,
          itemBuilder: (BuildContext context, int index) {
            return AppCardContainer(
              applyRadius: false,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              hasBorder: true,
              borderWidth: 2,
              borderColor: Colors.grey[300]!,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBannerImage(
                        height: 100,
                        width: 150,
                        applyImageRadius: false,
                        fit: BoxFit.cover,
                        imgUrl: images[index]),
                    SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          Obx(() {
                            return Checkbox(
                              activeColor: AppColors.secondary,
                              value: recommendationController.checkboxSelectedValues.contains(index),
                              onChanged: (bool? value) {
                                recommendationController.toggleCheckboxValue(index);
                              },
                            );
                          }),
                          SizedBox(
                            width: 100,
                            child: Text(
                              option[index],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
