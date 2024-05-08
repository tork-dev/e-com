import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../utils/device/device_utility.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title,
      this.actions,
      this.leadingIcon,
      this.leadingOnPress,
      required this.showBackArrow,
      this.showLeadingIcon = true,
      this.centerTitle = false,
      this.backgroundColor,
      this.leadingIconColor});

  final Widget? title;
  final bool showBackArrow, centerTitle, showLeadingIcon;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPress;
  final Color? backgroundColor, leadingIconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: leadingIconColor,
              ))
          : showLeadingIcon
              ? IconButton(
                  onPressed: leadingOnPress,
                  icon: Icon(leadingIcon, color: leadingIconColor))
              : null,
      title: title,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppDeviceUtils.getAppBarHeight());
}
