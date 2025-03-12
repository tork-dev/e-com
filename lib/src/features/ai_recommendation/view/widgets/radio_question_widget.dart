import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/logging/logger.dart';
import '../../controller/recommendation_controller.dart';

class RadioQuestionWidget extends StatelessWidget {
  final String question;
  final List option;
  const RadioQuestionWidget({
    super.key,
    required this.question,
    required this.option,
  });


  @override
  Widget build(BuildContext context) {
    final recommendationController = RecommendationController.instance;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            question,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(AppSizes.md),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: option.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.sm),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey[300]!)),
                  child: Obx(() {
                      return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                          dense: true,
                          activeColor: AppColors.secondary,
                          value: index,
                          groupValue: recommendationController.radioButtonSelectedValue.value,
                          onChanged: (value) {
                            recommendationController.setRadioButtonValue(value!);
                            Log.d(recommendationController.radioButtonSelectedValue.toString());
                          },
                        title: Text(
                          option[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  )

                  ),
              );
            }),

      ],
    );
  }
}