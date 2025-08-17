import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';


class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key,
        required this.showBackArrow,
        required this.showTabs,
        this.title,
        this.actions,
        this.leadingIcon,
        this.leadingOnPress, this.tabs, this.body});

  final Widget? title, body;
  final bool showBackArrow, showTabs;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPress;
  final dynamic tabs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
            onPressed: () => Get.back, icon: const Icon(Icons.arrow_back_ios_new_rounded))
            : IconButton(onPressed: leadingOnPress, icon: Icon(leadingIcon)),
        title: title,
        actions: actions,
      ),
      body: body,
    );
  }
}
