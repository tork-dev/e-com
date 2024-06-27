import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:torganic/src/features/questions/controller/question_controller.dart';
import 'package:torganic/src/features/questions/view/widgets/question_cards.dart';
import 'package:torganic/src/features/questions/view/widgets/question_post_card.dart';
import 'package:torganic/src/features/questions/view/widgets/questions_list.dart';

import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';

class QuestionScreen extends StatelessWidget {
  final int productId;
  const QuestionScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final QuestionController controller = Get.put(QuestionController(productId: productId));
    return AppLayoutWithBackButton(
        // bodyBackgroundColor: Colors.grey[100],
        title: const Text(
          'Questions',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        leadingIconColor: AppColors.darkGrey,
        padding: 0,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
              child: AppLayoutWithRefresher(
                  onRefresh: controller.onRefresh,
                  children:  [
                    SizedBox(
                      height: AppHelperFunctions.screenHeight() * .72,
                        child: const AppQuestionList())
                  ]),
            ),
            const Positioned(
                bottom: 0,
                child: AppQuestionPostCard()),

          ],
        ));
  }
}
