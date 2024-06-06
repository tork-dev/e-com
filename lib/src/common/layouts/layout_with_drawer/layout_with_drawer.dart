import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:torganic/src/common/drawer/view/end_drawer.dart';
import 'package:torganic/src/common/styles/spacing_style.dart';
import 'package:torganic/src/utils/constants/sizes.dart';
import 'package:torganic/src/utils/device/device_utility.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
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
    super.key,
  });

  final Widget title, body;
  final bool centerTitle, hasEndDrawer;
  final List<Widget>? action;
  final dynamic globalKey;
  final double padding;
  final Color? backgroundColor, leadingIconColor, bodyBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyBackgroundColor,
      resizeToAvoidBottomInset: true,
      key: globalKey,
      drawer: AppDrawer(),
      endDrawer: hasEndDrawer? const AppEndDrawer(
        userName: 'User Name',
        email: 'example@email.com',
      ): null,
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
    );
  }
}
