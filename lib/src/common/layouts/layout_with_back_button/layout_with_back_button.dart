import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/appbar/custom_app_bar.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

import '../../../utils/logging/logger.dart';

class AppLayoutWithBackButton extends StatelessWidget {
  const AppLayoutWithBackButton({
    this.padding = AppSizes.md,
    this.title,
    required this.body,
    this.centerTitle = false,
    this.action,
    this.backgroundColor,
    this.bodyBackgroundColor,
    this.showBackButton = true,
    this.customLeadingIcon,
    this.leadingIconColor,
    this.bottomNav,
    VoidCallback? leadingOnPress,
    this.backToHome = false,
    this.canPop = true,
    this.showCustomLeading = false,
    super.key,
  }): leadingOnPress = leadingOnPress ?? _defaultLeadingOnPress;
  static void _defaultLeadingOnPress() => Get.offAllNamed('/home');

  final Widget? title, body, bottomNav;
  final bool centerTitle;
  final Color? backgroundColor, leadingIconColor, bodyBackgroundColor;
  final List<Widget>? action;
  final bool showBackButton, showCustomLeading, backToHome, canPop;
  final double padding;
  final VoidCallback? leadingOnPress;
  final IconData? customLeadingIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        canPop: canPop,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          Log.d("pop invoked");
          if (!didPop) { // This means pop was prevented
            Log.d("pop invoked 2");
            if (backToHome) {
              Get.offAllNamed('/home'); // Navigate to home instead of popping
              Log.d("pop invoked 4");
            } else if (showCustomLeading && leadingOnPress != null) {
              Log.d("pop invoked 3");
              leadingOnPress!(); // Call custom leading function
            }
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: bodyBackgroundColor,
          bottomNavigationBar: bottomNav,
          appBar: CustomAppBar(
            title: title,
            leadingIcon: customLeadingIcon,
            showBackArrow: showBackButton,
            leadingIconColor: leadingIconColor,
            centerTitle: centerTitle,
            backgroundColor: backgroundColor,
            actions: action,
            leadingOnPress: leadingOnPress,
            showLeadingIcon: showCustomLeading,
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding), child: body),
        ),
      ),
    );
  }
}
