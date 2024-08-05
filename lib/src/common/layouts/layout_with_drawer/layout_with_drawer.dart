import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/view/end_drawer.dart';
import 'package:kirei/src/common/styles/spacing_style.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/device/device_utility.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../drawer/view/drawer.dart';
import '../../widgets/appbar/custom_app_bar.dart';

class AppLayoutWithDrawer extends StatelessWidget {
  const AppLayoutWithDrawer({
    required this.globalKey,
    required this.title,
    required this.body,
    this.backgroundColor = AppColors.primary,
    this.leadingIconColor = AppColors.white,
    this.hasEndDrawer = false,
    this.centerTitle = false,
    this.action,
    this.padding = 12,
    this.bodyBackgroundColor,
    this.isFromOtherPage = false,
    this.backToHome = false,
    this.inHome = false,
    super.key,
  });

  final Widget title, body;
  final bool centerTitle, hasEndDrawer, isFromOtherPage, backToHome, inHome;
  final List<Widget>? action;
  final dynamic globalKey;
  final double padding;
  final Color? backgroundColor, leadingIconColor, bodyBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !backToHome,
      onPopInvoked: (pop) {
        !inHome
            ? Get.offAll(() => const HelloConvexAppBar(
                  pageIndex: 0,
                ))
            : null;
      },

      child: Scaffold(
        backgroundColor: bodyBackgroundColor,
        resizeToAvoidBottomInset: true,
        key: globalKey,
        drawer: AppDrawer(isFromOtherPage: isFromOtherPage),
        endDrawer: hasEndDrawer ? const AppEndDrawer() : null,
        appBar: CustomAppBar(
          title: title,
          showBackArrow: false,
          leadingIcon: Icons.menu,
          leadingOnPress: () => globalKey.currentState!.openDrawer(),
          centerTitle: centerTitle,
          backgroundColor: backgroundColor,
          leadingIconColor: leadingIconColor,
          actions: action,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding), child: body),
      ),
    );
  }
}
