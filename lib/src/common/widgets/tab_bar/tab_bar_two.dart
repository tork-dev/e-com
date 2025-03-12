import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tab_controller.dart';


class AppTabBarTwo extends StatelessWidget {
  const AppTabBarTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final MyTabController tabx = Get.put(MyTabController());
    // ↑ init tab controllers

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabx.controller,
          tabs: tabx.myTabs,
        ),
      ),
      body: TabBarView(
        controller: tabx.controller,
        children: tabx.myTabs.map((Tab tab) {
          final String label = tab.text!;
          return Center(
            child: Text(
              'This is the $label tab',
              style: const TextStyle(fontSize: 36),
            ),
          );
        }).toList(),
      ),
    );
  }
}