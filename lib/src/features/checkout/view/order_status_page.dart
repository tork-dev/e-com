import 'package:flutter/material.dart';
import 'package:torganic/src/common/layouts/layout_without_appbar/layout_without_appbar.dart';

class AppOrderStatusScreen extends StatelessWidget {

  final String status;
  const AppOrderStatusScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return AppLayoutWithoutAppBar(
        body: Center(
      child: Text(
        status,
        style: TextStyle(fontSize: 48),
      ),
    ));
  }
}
