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

class RadioQuestionImageWidget extends StatelessWidget {
  final String question;
  final List option, images;

  const RadioQuestionImageWidget(
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
            mainAxisExtent: 195,
            // childAspectRatio: .60
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: option.length,
          itemBuilder: (BuildContext context, int index) {
            return AppCardContainer(
              onTap: (){
                recommendationController
                    .setRadioButtonValue(index);
              },
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
                      child: Obx(() {
                          return RadioListTile(
                            activeColor: AppColors.secondary,
                            value: index,
                            groupValue: recommendationController.radioButtonSelectedValue.value,
                            onChanged: (value){},
                            title: Text(
                              option[index],
                              maxLines: 2,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            contentPadding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(horizontal: -4.0, vertical: -2.0),
                          );
                        }
                      )

                      // Row(
                      //   children: [
                      //     Obx(() {
                      //       return Radio<int>(
                      //           activeColor: AppColors.secondary,
                      //           value: index,
                      //           groupValue: recommendationController
                      //               .radioButtonSelectedValue.value,
                      //           onChanged: (value) {
                      //             recommendationController
                      //                 .setRadioButtonValue(value!);
                      //           });
                      //     }),
                      //     SizedBox(
                      //       width: 100,
                      //       child: Text(
                      //         option[index],
                      //         style: const TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //     )
                      //   ],
                      // ),
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
