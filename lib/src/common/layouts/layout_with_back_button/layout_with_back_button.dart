import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/view/drawer.dart';
import 'package:kirei/src/common/widgets/appbar/custom_app_bar.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/spacing_style.dart';

class AppLayoutWithBackButton extends StatelessWidget {
  const AppLayoutWithBackButton({
  required this.padding,
    this.title,
    required this.body,
    this.centerTitle = false,
    this.action,
    this.backgroundColor,
    this.bodyBackgroundColor,
    this.showBackButton = true,
    this.backToHome = false,
    this.leadingIconColor,
    this.bottomNav,
    this.leadingOnPress,
    super.key,  });

  final Widget? title, body, bottomNav;
  final bool centerTitle, backToHome;
  final Color? backgroundColor, leadingIconColor, bodyBackgroundColor;
  final List<Widget>? action;
  final bool showBackButton;
  final double padding;
  final VoidCallback? leadingOnPress;


  @override
  Widget build(BuildContext context) {
    //final isDark = AppHelperFunctions.isDarkMode(context);
    return PopScope(
      canPop: !backToHome,
      onPopInvoked: (pop){
        Get.offAll(()=> const HelloConvexAppBar(pageIndex: 0,));
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodyBackgroundColor,
        bottomNavigationBar: bottomNav,
        appBar: CustomAppBar(
          title: title,
          showBackArrow: showBackButton,
          leadingIconColor: leadingIconColor,
          centerTitle: centerTitle,
          backgroundColor: backgroundColor,
          actions: action,
          leadingOnPress:()=> leadingOnPress,
        ),
        body: Padding(padding: EdgeInsets.symmetric(horizontal: padding), child: body),
      ),
    );
  }
}

