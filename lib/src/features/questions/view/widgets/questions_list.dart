import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/layouts/listview_layout/listview_layout.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/questions/controller/question_controller.dart';

import 'question_cards.dart';

class AppQuestionList extends StatelessWidget {
  const AppQuestionList({super.key});

  @override
  Widget build(BuildContext context) {
    final questionController = QuestionController.instance;
    return Obx(() {
      return questionController.apiHitting.value == false &&
              questionController.questionResponse.value.data!.isEmpty
          ? const Center(child: Text('No question here...'))
          : AppListViewLayout(
              itemCount: questionController.apiHitting.value
                  ? 5
                  : questionController.questionResponse.value.data!.length,
              builderFunction: (context, index) {
                return questionController.apiHitting.value
                    ? ShimmerHelper().buildBasicShimmer(height: 150)
                    : Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppQuestionCards(
                            name: questionController
                                .questionResponse.value.data![index].name!,
                            time: questionController
                                .questionResponse.value.data![index].time!,
                            description: questionController
                                .questionResponse.value.data![index].text!,
                          ),
                          AppListViewLayout(
                              itemCount: questionController.questionResponse
                                  .value.data![index].replies!.length,
                              builderFunction: (context, replyIndex) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: AppQuestionCards(
                                    name: questionController
                                            .questionResponse
                                            .value
                                            .data![index]
                                            .replies?[replyIndex]
                                            .name ??
                                        '',
                                    time: questionController
                                            .questionResponse
                                            .value
                                            .data![index]
                                            .replies?[replyIndex]
                                            .time ??
                                        '',
                                    description: questionController
                                            .questionResponse
                                            .value
                                            .data![index]
                                            .replies?[replyIndex]
                                            .text ??
                                        '',
                                  ),
                                );
                              })
                        ],
                      );
              });
    });
  }
}
