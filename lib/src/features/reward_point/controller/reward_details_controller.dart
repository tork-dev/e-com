import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/logging/logger.dart';

class RewardDetailsController extends GetxController{
  static RewardDetailsController get instance => Get.find();

  final ScrollController scrollController = ScrollController();
  final GlobalKey targetWidgetToScroll = GlobalKey();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if(Get.arguments == 'redeem'){
      Log.d('redeem');
      scrollToTargetWidget();
    }
  }

  void scrollToTargetWidget() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final context = targetWidgetToScroll.currentContext;
      // // if (context != null) {
      // //   print('executing');
      // //   final box = context.findRenderObject() as RenderBox;
      // //   final position = box.localToGlobal(Offset.zero).dy;
        const scrollPosition = 1700.00;

        scrollController.animateTo(
          scrollPosition,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      // }
    });
  }
}