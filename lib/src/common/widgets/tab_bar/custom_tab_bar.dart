import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/device/device_utility.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTabBar({required this.tabs, super.key});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Material(
      color: isDark? AppColors.black : AppColors.white,
      child: TabBar(
          isScrollable: true,
          indicatorColor: AppColors.primary,
          unselectedLabelColor: AppColors.grey,
          labelColor: AppColors.primary,
          tabs: tabs
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppDeviceUtils.getAppBarHeight());
}

