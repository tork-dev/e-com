import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/view/drawer.dart';
import 'package:kirei/src/common/widgets/appbar/custom_app_bar.dart';
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/features/home/views/home_three.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/spacing_style.dart';

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
    this.leadingOnPress,
    this.backToHome = false,
    this.showCustomLeading = false,
    super.key,
  });

  final Widget? title, body, bottomNav;
  final bool centerTitle;
  final Color? backgroundColor, leadingIconColor, bodyBackgroundColor;
  final List<Widget>? action;
  final bool showBackButton, showCustomLeading, backToHome;
  final double padding;
  final VoidCallback? leadingOnPress;
  final IconData? customLeadingIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        canPop: !backToHome,
        onPopInvoked: (bool didPop) async {
          if (!didPop) {
            bool popped = await Navigator.maybePop(context);
            if (!popped) {
              if (backToHome) {
                // Navigator.popUntil(context, (HomeThree) => false);
                Get.offAllNamed('/home');
              } else if (showCustomLeading && leadingOnPress != null) {
                leadingOnPress!();
              }
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
