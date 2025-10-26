import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/view/end_drawer.dart';
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
    this.bottomNav,
    super.key,
  });

  final Widget title, body;
  final Widget? bottomNav;
  final bool centerTitle, hasEndDrawer, isFromOtherPage, backToHome, inHome;
  final List<Widget>? action;
  final dynamic globalKey;
  final double padding;
  final Color? backgroundColor, leadingIconColor, bodyBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        canPop: !backToHome,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          !inHome
              ? Get.offAllNamed("/home")
              : null;
        },

        child: Scaffold(
          backgroundColor: bodyBackgroundColor,
          resizeToAvoidBottomInset: true,
          key: globalKey,
          drawer: AppDrawer(isFromOtherPage: isFromOtherPage),
          endDrawer: hasEndDrawer ? const AppEndDrawer() : null,
          bottomNavigationBar: bottomNav,
          appBar: CustomAppBar(
            title: title,
            showBackArrow: false,
            leadingIcon: Icons.menu_rounded,
            leadingOnPress: () => globalKey.currentState!.openDrawer(),
            centerTitle: centerTitle,
            backgroundColor: backgroundColor,
            leadingIconColor: leadingIconColor,
            actions: action,
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding), child: body),
        ),
      ),
    );
  }
}
