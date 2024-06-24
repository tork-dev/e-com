import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:torganic/src/common/layouts/layout_with_refresher/layout_with_refresher.dart';
import 'package:torganic/src/features/questions/controller/question_controller.dart';
import 'package:torganic/src/features/questions/view/widgets/question_cards.dart';
import 'package:torganic/src/features/questions/view/widgets/question_post_card.dart';

import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionController controller = Get.put(QuestionController());
    return AppLayoutWithBackButton(
        // bodyBackgroundColor: Colors.grey[100],
        title: const Text(
          'Reviews',
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
                  children: const [
                    AppQuestionCards(),
                  ]),
            ),
            const Positioned(
                bottom: 0,
                child: AppQuestionPostCard()),

          ],
        ));
  }
}
